#include <stdint.h>
#include <string.h>
#include <stdio.h>

/* From http://software.intel.com/en-us/articles/intel-digital-random-number-generator-drng-software-implementation-guide/ */

#include "rdrand.h"

#define cpuid(in, eax, ebx, ecx, edx)   \
  asm("cpuid":  "=a" (eax),             \
                "=b" (ebx),             \
                "=c" (ecx),             \
                "=d" (edx) : "a" (in))

int cpucheck(void)
{	
	uint32_t eax, ebx, ecx, edx = 0;

	cpuid(0, eax, ebx, ecx, edx);
	if (!((memcmp(&ebx, "Genu", 4) == 0) &&
	      (memcmp(&edx, "ineI", 4) == 0) &&
	      (memcmp(&ecx, "ntel", 4) == 0))) {
		return 1;
	}
	cpuid(1, eax, ebx, ecx, edx);
	if (!(ecx & 0x40000000)) {
		return 2;
	}

	return 0;
}

static inline int __rdrand16(uint16_t *val)
{
	uint16_t 	tmp;
	int 		ret;

        asm("rdrand %%ax;\n\
        mov $1,%%edx;\n\
        cmovae %%ax,%%dx;\n\
        mov %%edx,%1;\n\
        mov %%ax, %0;":"=r"(tmp),"=r"(ret)::"%ax","%dx");

        *val = tmp;
	return ret;
}

static inline int __rdrand32(uint32_t *val)
{
	uint32_t 	tmp;
	int 		ret;

        asm("rdrand %%eax;\n\
        mov $1,%%edx;\n\
        cmovae %%eax,%%edx;\n\
        mov %%edx,%1;\n\
        mov %%eax, %0;":"=r"(tmp),"=r"(ret)::"%eax","%edx");

        *val = tmp;
	return ret;
}

static inline int __rdrand64(uint64_t *val)
{
	uint64_t	tmp;
	int 		ret;

        asm("rdrand %%rax;\n\
        mov $1,%%edx;\n\
        cmovae %%rax,%%rdx;\n\
        mov %%edx,%1;\n\
        mov %%rax, %0;":"=r"(tmp),"=r"(ret)::"%rax","%rdx");

        *val = tmp;
	return ret;
}

uint16_t rdrand16(void)
{
        uint16_t val;
        while (__rdrand16(&val) == 0);
        return val;
}

uint32_t rdrand32(void)
{
        uint32_t val;
        while (__rdrand32(&val) == 0);
        return val;
}

uint64_t rdrand64(void)
{
        uint64_t val;
        while (__rdrand64(&val) == 0);
        return val;
}
