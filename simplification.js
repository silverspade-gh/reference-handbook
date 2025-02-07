// simplification.js
// Simplifying conditionals

// 1. SIMPLIFY
if (a !== null) {
    if (a.propertyA !== someValue) {
        b.propertyB = 'value2'
    }
}
else {
    b.propertyB = 'value2'
}

// 1. SIMPLIFIES TO
if (a === null || a.propertyA !== someValue) {
    b.propertyB = 'value2'
}
