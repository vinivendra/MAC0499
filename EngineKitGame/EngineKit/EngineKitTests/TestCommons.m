

#import "TestCommons.h"


void setupRandomSeed() {
    NSDateComponents *components = [[NSCalendar currentCalendar]
                                    components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                    fromDate:[NSDate date]];

    unsigned int seed = (unsigned int)components.day
    + (unsigned int)components.month * 31
    + (unsigned int)components.year * 12 * 31;

    srand(seed);
}


CGFloat randomFloat() {

    CGFloat f = ((double)rand() / rand()) - ((double)rand() / rand());
    f = f * f * f;

    if (f == 0) return randomFloat();

    return f;
}