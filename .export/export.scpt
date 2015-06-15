on dirname(f)
 return (POSIX file (do shell script "dirname " & quoted form of POSIX path of f) as alias)
end dirname

set projDir to (dirname(dirname(path to me)) as text)

set docName to projDir & "Key Terms.numbers"
set csvDir to projDir & ".export:csv"

tell application "Numbers"
    open docName
    export front document to file csvDir as CSV
end tell

