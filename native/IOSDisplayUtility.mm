#include <bbmonkey.h>

bbString IOSDeviceName(){
    return bbString( [[UIDevice currentDevice] model] );
}
