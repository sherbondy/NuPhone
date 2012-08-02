(load "nu")
(load "cocoa")
(load "util")

(class NPViewController is UIViewController
  (ivar (id) view)

  (- (void)loadView is
     (super loadView)
     (set @view ((UIView alloc) initWithFrame:$screenRect))
     (@view setBackgroundColor:(UIColor blackColor))
     (self setView:@view)))

(class NPAppDelegate is UIResponder
  (ivar (id) window 
        (id) rootVC)

  (- (BOOL)application:(id)application didFinishLaunchingWithOptions:(id)launchOptions is
    ;; Set up the window and content view
    (set $screenRect ((UIScreen mainScreen) bounds))
    (set @window ((UIWindow alloc) initWithFrame:$screenRect))
    (@window setBackgroundColor:(UIColor whiteColor))
    
    (log (+ 1 1) "testing")
    (log "Hello" "There " "Old Friend" @window 1)
    
    (set @rootVC ((NPViewController alloc) init))
    (@window setRootViewController:@rootVC)
    
    ;; Show the window
    (@window makeKeyAndVisible)))