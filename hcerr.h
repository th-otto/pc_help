HCERR(ERR_OPEN_OUTPUT, "unable to open output file \"%s\"")
HCERR(ERR_OPEN_SOURCE, "unable to open source file \"%s\"")
HCERR(ERR_OPEN_PROJECT, "unable to open project file \"%s\"")
HCERR(ERR_NOMEM, "out of memory")
HCERR(ERR_WRITE_ERROR, "write error on \"%s\"")
#if WITH_FIXES
HCERR(ERR_READ_ERROR, "read error on \"%s\"") /* BUG: wrong format */
#else
HCERR(ERR_READ_ERROR, "read error on \"%\"s") /* BUG: wrong format */
#endif
HCERR(ERR_TOO_MANY_FILES, "too many source files in project \"%s\"")
HCERR(ERR_TOO_MANY_SCREENS, "too many screens")
HCERR(ERR_UNKNOWN_STATEMENT, "unknown statement")
HCERR(ERR_MISSING_PARAMETER_LIST, "missing parameter list")
HCERR(ERR_INCOMPLETE_LIST, "incomplete parameter list")
HCERR(ERR_MISSING_END, "missing end of screen")
HCERR(ERR_SCREEN_TO_LONG, "screen too long")
HCERR(ERR_WRONG_SCOPE, "wrong scope for statement")
HCERR(ERR_PENDING_KEYWORD, "pending keyword delimiter")
HCERR(ERR_CANT_BREAK, "can't break keyword")
HCERR(ERR_WRONG_ARGUMENT, "wrong argument type")
HCERR(ERR_DUPLICATE_SCREEN, "doubly defined screen name \"%s\"")
HCERR(ERR_PENDING_STRING, "pending end of string")
HCERR(ERR_EXPECTED, "'=' expected in -%c option")
HCERR(ERR_OPTION, "illegal option character: %c")
HCERR(ERR_FILE_INDEX, "file index out of range: %c")
HCERR(ERR_ILLEGAL_CHARACTER, "use of illegal character: %d")
HCERR(ERR_PARENTHESIS, "perenthesis error")
HCERR(ERR_TOO_MANY_PARAMETERS, "too many parameters")
HCERR(ERR_MISSING_PARAMETER, "missing parameter")
HCERR(ERR_UNKNOWN_SCREEN, "reference to unknown screen \"%s\"")
#if WITH_FIXES
HCERR(ERR_STRING_MISMATCH, "string size mismatch")
#endif
#undef HCERR
