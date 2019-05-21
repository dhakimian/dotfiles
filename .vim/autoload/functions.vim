"https://stackoverflow.com/a/18810980
fun functions#Reduce(list, func)
    let acc = a:list[0]
    for value in a:list[1:]
        let acc = a:func(acc, value)
    endfor
    return acc
endfun

"fun functions#BoolReduceAnd(list, func)
"    if len(a:list) == 1 | return 1 | endif
"    let acc = 1
"    for value in a:list
"        let acc = acc && a:func(acc, value)
"        if !acc | return 0 | endif
"    endfor
"    return acc
"endfun

"return the longest matching substring of two strings (starting from the beginning of the strings)
function! functions#GreatestCommonPrefix(str1, str2)
    let l = min([strlen(a:str1), strlen(a:str2)])
    "prefixlen serves as both the string position iterator and the return value
    let prefixlen = 0
    while prefixlen < l && strpart(a:str1, prefixlen, 1) == strpart(a:str2, prefixlen, 1)
        let prefixlen += 1
    endwhile
    "could use either string here, but we'll just use the first
    return strpart(a:str1, 0, prefixlen)
endfunction

"return the longest matching substring (as above) of all the strings in a list
"function! functions#GreatestCommonPrefixList(list)
"    if len(a:list) == 1
"        return a:list[0]
"    endif
"    let prefix_so_far = functions#GreatestCommonPrefix(a:list[0], a:list[1])
"    let i = 1
"    while i < len(a:list)-1
"        let prefix = functions#GreatestCommonPrefix(a:list[i], a:list[i+1])
"        if prefix_so_far != prefix
"            prefix_so_far = functions#GreatestCommonPrefix(prefix_so_far, prefix)
"        let i += 1
"    endwhile
"endfunction
function! functions#GreatestCommonPrefixList(list)
    if len(a:list) < 1 | return '' | endif
    if len(a:list) == 1 | return a:list[0] | endif
    let l = min(map(copy(a:list), { key,val -> strlen(val) }))
    "prefixlen serves as both the string position iterator and the return value
    let prefixlen = 0
    let charsmatch = 1
    while prefixlen < l && charsmatch
        let i = 0
        while i < len(a:list)-1
            if strpart(a:list[i], prefixlen, 1) != strpart(a:list[i+1], prefixlen, 1)
                let charsmatch = 0
                break
            endif
            let i+=1
        endwhile
        if charsmatch | let prefixlen += 1 | endif
    endwhile
    return strpart(a:list[0], 0, prefixlen)
endfunction

function! functions#UltiSnipsComplete(findstart, base)
    if a:findstart
        "snippet triggers can potentially start in the middle of words or have spaces in them, etc.,
        "so standard lookback for keyword chars or similar to find the completion start won't work.
        "Fortunately, the SnippetsInCurrentScope function already limits the candidates it returns
        "to the only valid triggers that could be formed by typing 0+ more characters on the current
        "line, so we can just search back in the current line based on the list it returns.
        let b:ulti_compl_candidates = UltiSnips#SnippetsInCurrentScope()
        let line = getline('.')
        let gcp = functions#GreatestCommonPrefixList(keys(b:ulti_compl_candidates))
        "gcp could have more characters than what we typed, so if we don't see the full gcp at the
        "end of this line, we crop off characters from the end of the gcp until we do see it there.
        let start = col('.') - 1 - strlen(gcp)
        let line_to_cursor = strpart(line, 0, col('.')-1)
        while start < col('.')-1 && (start < 0 || strridx(line_to_cursor, gcp) != start)
            let start += 1
            let gcp = strpart(gcp, 0, strlen(gcp)-1)
        endwhile
        return start
    else
        "let ret = {'words': [], 'refresh': 'always'}
        let ret = {'words': []}
        for c in keys(b:ulti_compl_candidates)
            call add(ret.words, {'word': c, 'menu': b:ulti_compl_candidates[c]})
        endfor
        unlet b:ulti_compl_candidates
        return ret
    endif
endfunction


