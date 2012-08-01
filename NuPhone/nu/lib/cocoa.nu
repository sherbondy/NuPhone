;; @file       cocoa.nu
;; @discussion Global constants useful for programming in Cocoa.
;; Currently, these are manually set, but in the future,
;; they may be read from Mac OS 10.5's Bridge Support files.
;;
;; @copyright Copyright (c) 2007 Tim Burks, Radtastical Inc.
;;
;;   Licensed under the Apache License, Version 2.0 (the "License");
;;   you may not use this file except in compliance with the License.
;;   You may obtain a copy of the License at
;;
;;       http://www.apache.org/licenses/LICENSE-2.0
;;
;;   Unless required by applicable law or agreed to in writing, software
;;   distributed under the License is distributed on an "AS IS" BASIS,
;;   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;;   See the License for the specific language governing permissions and
;;   limitations under the License.

(macro bridge (kind name signature)
     (case kind
           ('constant
                     `(global ,name (NuBridgedConstant constantWithName:(',name stringValue) signature:,signature)))
           ('function
                     `(global ,name (NuBridgedFunction functionWithName:(',name stringValue) signature:,signature)))
           (else
                `(NSLog "invalid argument to bridge: '#{,kind}'"))))

(bridge function NSLog "v@")
(bridge function UIApplicationMain "ii^*")

(global NSOrderedAscending 				-1)
(global NSOrderedSame       			0)
(global NSOrderedDescending 			1)

