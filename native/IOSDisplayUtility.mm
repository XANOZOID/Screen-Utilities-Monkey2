// Added in by Mark Sibly (Tagged by Abe Noll)
#include "IOSDisplayUtility.h"

#include <UIKit/UIKit.h>

bbString IOSDeviceName(){
    return bbString( [[UIDevice currentDevice] model] );
}
