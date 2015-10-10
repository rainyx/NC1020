#ifndef NC1020_H_
#define NC1020_H_

#include <stddef.h>
#include <stdint.h>
#include <string>
namespace wqx {
struct WqxRom {
    std::string romPath;
    std::string norFlashPath;
    std::string statesPath;
};
typedef struct WqxRom WqxRom;
extern void Initialize(WqxRom);
extern void Reset();
extern void SetKey(uint8_t, bool);
extern void RunTimeSlice(size_t, bool);
extern bool CopyLcdBuffer(uint8_t*);
extern void LoadNC1020();
extern void SaveNC1020();

}

#endif /* NC1020_H_ */
