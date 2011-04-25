#ifndef ML_IRR_BASE_H
#define ML_IRR_BASE_H

#include "global.h"

value copy_SKeyInput(SEvent::SKeyInput);

SEvent::SKeyInput SKeyInput_val(value);

value copy_SMouseInput(SEvent::SMouseInput);

value copy_SEvent(SEvent);

SEvent SEvent_val(value);

#endif
