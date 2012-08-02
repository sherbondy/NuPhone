(load "nu")
(load "cocoa")
(load "util")

(class NPAppDelegate is UIResponder
  (ivar (id) window 
        (id) rootVC)

  (- (BOOL)application:(id)application didFinishLaunchingWithOptions:(id)launchOptions is
    ;; Set up the window and content view
    (set screenRect ((UIScreen mainScreen) bounds))
    (set @window ((UIWindow alloc) initWithFrame:screenRect))
    (@window setBackgroundColor:(UIColor whiteColor))
    
    (log "#{(+ 1 1)} testing")
    (log "Hello" "There " "Old Friend" @window 1)
    
    (set @rootVC ((UIViewController alloc) init))
    (@window setRootViewController:@rootVC)
    
    ;; Show the window
    (@window makeKeyAndVisible)))