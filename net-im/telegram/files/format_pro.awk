#!/usr/bin/awk -f

BEGIN {
    var = ""
    in_breaked_line = 0
}

{
    if ( in_breaked_line ) {
        if ( match($0,"(.*)(.)", a) == 0) {
            in_breaked_line = 0
            print
            next
        }

        if ( a[2] != "\\" ){
            in_breaked_line = 0
        }
        print var,"+=",( in_breaked_line ? a[1] : $0 )
        next
    }

    if( match($0, "^ *([A-Z_]*)[^=]*=(.*)\\\\$", a) == 0 ) {
        print
    } else {
        in_breaked_line = 1
        var = a[1]
        print var,"+=",a[2]
    }
}
