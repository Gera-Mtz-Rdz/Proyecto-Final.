//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef _LIBCPP___ALGORITHM_PARTIAL_SORT_H
#define _LIBCPP___ALGORITHM_PARTIAL_SORT_H

#include <__config>
#include <__algorithm/comp.h>
#include <__algorithm/comp_ref_type.h>
#include <__algorithm/make_heap.h>
#include <__algorithm/sift_down.h>
#include <__algorithm/sort_heap.h>
#include <__iterator/iterator_traits.h>
#include <type_traits> // swap

#if !defined(_LIBCPP_HAS_NO_PRAGMA_SYSTEM_HEADER)
#pragma GCC system_header
#endif

_LIBCPP_PUSH_MACROS
#include <__undef_macros>

_LIBCPP_BEGIN_NAMESPACE_STD

template <class _Compare, class _RandomAccessIterator>
_LIBCPP_CONSTEXPR_AFTER_CXX17 void
__partial_sort(_RandomAccessIterator __first, _RandomAccessIterator __middle, _RandomAccessIterator __last,
             _Compare __comp)
{
    _VSTD::__make_heap<_Compare>(__first, __middle, __comp);
    typename iterator_traits<_RandomAccessIterator>::difference_type __len = __middle - __first;
    for (_RandomAccessIterator __i = __middle; __i != __last; ++__i)
    {
        if (__comp(*__i, *__first))
        {
            swap(*__i, *__first);
            _VSTD::__sift_down<_Compare>(__first, __middle, __comp, __len, __first);
        }
    }
    _VSTD::__sort_heap<_Compare>(__first, __middle, __comp);
}

template <class _RandomAccessIterator, class _Compare>
inline _LIBCPP_INLINE_VISIBILITY _LIBCPP_CONSTEXPR_AFTER_CXX17
void
partial_sort(_RandomAccessIterator __first, _RandomAccessIterator __middle, _RandomAccessIterator __last,
             _Compare __comp)
{
    typedef typename __comp_ref_type<_Compare>::type _Comp_ref;
    _VSTD::__partial_sort<_Comp_ref>(__first, __middle, __last, __comp);
}

template <class _RandomAccessIterator>
inline _LIBCPP_INLINE_VISIBILITY _LIBCPP_CONSTEXPR_AFTER_CXX17
void
partial_sort(_RandomAccessIterator __first, _RandomAccessIterator __middle, _RandomAccessIterator __last)
{
    _VSTD::partial_sort(__first, __middle, __last,
                       __less<typename iterator_traits<_RandomAccessIterator>::value_type>());
}

_LIBCPP_END_NAMESPACE_STD

_LIBCPP_POP_MACROS

#endif // _LIBCPP___ALGORITHM_PARTIAL_SORT_H
