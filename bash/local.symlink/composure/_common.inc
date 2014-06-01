_common () 
{ 
    author 'Nick Hildebrant';
    about 'functions factored out for reuse';
    group 'lib';
}

pushd() { builtin pushd "$@" >/dev/null; }
popd() { builtin popd "$@" ; }
