(load "nu")
(load "cocoa")
(load "match")
(load "util")

(global UIButtonTypeCustom 0)
(global UIControlStateNormal 0)
(global UIButtonTypeRoundedRect 1)
(global UIControlEventTouchUpInside (<< 1 6))
(global UIBarButtonItemStyleBordered 1)

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
    (self setRightBarButton:(buttons 1))))

(class NPViewController is UIViewController
  (ivar (id) view
        (id) button)

  (- (id)title is "Hello World #{(self depth)}!")

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
    (log "View Source"))

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