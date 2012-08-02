(load "nu")
(load "cocoa")
(load "util")

(global UIButtonTypeCustom 0)
(global UIControlStateNormal 0)
(global UIButtonTypeRoundedRect 1)
(global UIControlEventTouchUpInside (<< 1 6))

(class NPViewController is UIViewController
  (ivar (id) view
        (id) button)

  (- (id)title is "Hello World!")

  (- (void)hello is 
    (alert "hi"))

  (- (void)addButton is
     (set @button (UIButton buttonWithType:UIButtonTypeRoundedRect))
     (@button setTitle:"Push Me!" forState:UIControlStateNormal)
     (@button setSize:'(240 40))
     (@button setCenter:(@view center))
     (@button addTarget:self action:"hello" 
       forControlEvents:UIControlEventTouchUpInside)
     (@view addSubview:@button))

  (- (void)loadView is
     (super loadView)
     (set @view ((UIView alloc) initWithFrame:((self view) frame)))
     (@view setBackgroundColor:(UIColor whiteColor))
     (self setView:@view)
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