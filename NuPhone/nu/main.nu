(load "nu")
(load "cblocks")
(load "cocoa")
(load "match")
(load "util")

(global UIButtonTypeCustom 0)
(global UIControlStateNormal 0)
(global UIButtonTypeRoundedRect 1)
(global UIControlEventTouchUpInside (<< 1 6))
(global UIBarButtonItemStyleBordered 1)

(global UIBarButtonSystemItemDone 0)
(global UIBarButtonSystemItemCancel 1)
(global UIBarButtonSystemItemEdit 2)
(global UIBarButtonSystemItemSave 3)

(global UIKeyboardWillShowNotification "UIKeyboardWillShowNotification")
(global UIKeyboardFrameEndUserInfoKey "UIKeyboardFrameEndUserInfoKey")
(global UIKeyboardAnimationDurationUserInfoKey "UIKeyboardAnimationDurationUserInfoKey")

(class UIViewController
  (- (void)push:(id)vc is
    ((self navigationController) pushViewController:vc animated:YES))

  (- (id)depth is
    (((self navigationController) viewControllers) count))

  (- (void)setLeftBarButton:(id)button is
    ((self navigationItem) setLeftBarButtonItem:button))

  (- (void)setRightBarButton:(id)button is
    ((self navigationItem) setRightBarButtonItem:button))

  (- (void)setBarButtons:(id)buttons is
    (self setLeftBarButton:(buttons 0))
    (self setRightBarButton:(buttons 1)))

  (- (void)leftAction is
    (log "Should be overwritten by subclass"))

  (- (void)rightAction is
    (log "Should be overwritten by subclass"))

  (- (void)setSystemBarButtons:(id)systemButtons is
    (self setLeftBarButton:((UIBarButtonItem alloc) initWithBarButtonSystemItem:(systemButtons 0) target:self action:"leftAction"))
    (self setRightBarButton:((UIBarButtonItem alloc) initWithBarButtonSystemItem:(systemButtons 1) target:self action:"rightAction"))))


(class NPSourceEditorController is UIViewController
  (ivar (id) _navController
        (id) view
        (id) textView)

  (- (id)title is "Edit Source")

  (- (id)navController is
    (if (not (self navigationController))
      (set @_navController ((UINavigationController alloc) initWithRootViewController:self)))
    @_navController)

  (- (id)leftAction is
    (self dismissModalViewControllerAnimated:YES))

  (- (id)rightAction is
    (log "Should save first")
    (self leftAction))

  (- (id)showingKeyboard:(id)notification is
    (log "Need to write Objective-c wrapper for CGRect"))

  (- (id)loadView is
    (super loadView)
    ((NSNotificationCenter defaultCenter) addObserver:self selector:"showingKeyboard:" name:UIKeyboardWillShowNotification object:nil)
    (set @view ((UIView alloc) initWithFrame:((self view) frame)))
    (@view setBackgroundColor:(UIColor whiteColor))
    (set @textView ((UITextView alloc) initWithFrame:'(0 0 320 200)))
    (@textView setContentInset:'(0 16 0 16))
    (@textView setFont:(UIFont systemFontOfSize:18))
    (@view addSubview:@textView)
    (self setView:@view)
    (self setSystemBarButtons:(list UIBarButtonSystemItemCancel UIBarButtonSystemItemSave)))

  (- (id)viewDidAppear:(BOOL)animated is
    (super viewDidAppear:animated)
    (@textView becomeFirstResponder))

  (- (id)viewDidUnload is
    ((NSNotificationCenter defaultCenter) removeObserver:self)))

(class NPViewController is UIViewController
  (ivar (id) view
        (id) button
        (id) _sourceVC)

  (- (id)title is "Hello World #{(self depth)}!")

  (- (id)sourceVC is
    (if (not @_sourceVC)
      (set @_sourceVC ((NPSourceEditorController alloc) init)))
    @_sourceVC)

  (- (void)hello is 
    (alert "hi"))

  (- (void)addButton is
    (set @button (UIButton buttonWithType:UIButtonTypeRoundedRect))
    (@button setTitle:"Press Me!" forState:UIControlStateNormal)
    (@button setSize:'(240 40))
    (@button setCenter:(@view center))
    (@button addTarget:self action:"hello" 
      forControlEvents:UIControlEventTouchUpInside)
    (@view addSubview:@button))

  (- (void)pushAnother is
   (self push:((self class) new)))

  (- (void)viewSource is
    (log "View Source")
    (self presentModalViewController:((self sourceVC) navController) animated:YES))

  (- (void)loadView is
    (super loadView)
    (set @view ((UIView alloc) initWithFrame:((self view) frame)))
    (@view setBackgroundColor:(UIColor whiteColor))
    (self setView:@view)

    (set rightButton ((UIBarButtonItem alloc) initWithTitle:"Another" style:UIBarButtonItemStyleBordered target:self action:"pushAnother"))
    (set leftButton 
      (if (eq 1 (self depth))
        ((UIBarButtonItem alloc) initWithTitle:"View Source" style:UIBarButtonItemStyleBordered target:self action:"viewSource")))

    (self setBarButtons:(list leftButton rightButton))

    (self addButton)))

(class NPAppDelegate is UIResponder
  (ivar (id) window 
        (id) rootVC)

  (- (BOOL)application:(id)application didFinishLaunchingWithOptions:(id)launchOptions is
    ;; Set up the window and content view
    (set screenRect ((UIScreen mainScreen) bounds))
    (set @window ((UIWindow alloc) initWithFrame:screenRect))
    (@window setBackgroundColor:(UIColor blackColor))
    
    (log (+ 1 1) "testing")
    (log "Hello" "There " "Old Friend" @window 1)
    (log ((NSBundle mainBundle) resourcePath))
    
    (set @rootVC ((NPViewController alloc) init))
    (set navController ((UINavigationController alloc) initWithRootViewController:@rootVC))

    (@window setRootViewController:navController)
    
    ;; Show the window
    (@window makeKeyAndVisible)))