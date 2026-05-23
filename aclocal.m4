# generated automatically by aclocal 1.16.5 -*- Autoconf -*-

# Copyright (C) 1996-2021 Free Software Foundation, Inc.

# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

m4_ifndef([AC_CONFIG_MACRO_DIRS], [m4_defun([_AM_CONFIG_MACRO_DIRS], [])m4_defun([AC_CONFIG_MACRO_DIRS], [_AM_CONFIG_MACRO_DIRS($@)])])
# ===========================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_check_compile_flag.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_COMPILE_FLAG(FLAG, [ACTION-SUCCESS], [ACTION-FAILURE], [EXTRA-FLAGS], [INPUT])
#
# DESCRIPTION
#
#   Check whether the given FLAG works with the current language's compiler
#   or gives an error.  (Warnings, however, are ignored)
#
#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
#   success/failure.
#
#   If EXTRA-FLAGS is defined, it is added to the current language's default
#   flags (e.g. CFLAGS) when the check is done.  The check is thus made with
#   the flags: "CFLAGS EXTRA-FLAGS FLAG".  This can for example be used to
#   force the compiler to issue an error when a bad flag is given.
#
#   INPUT gives an alternative input source to AC_COMPILE_IFELSE.
#
#   NOTE: Implementation based on AX_CFLAGS_GCC_OPTION. Please keep this
#   macro in sync with AX_CHECK_{PREPROC,LINK}_FLAG.
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#   Copyright (c) 2011 Maarten Bosmans <mkbosmans@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 11

AC_DEFUN([AX_CHECK_COMPILE_FLAG],
[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF
AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]flags_$4_$1])dnl
AC_CACHE_CHECK([whether the _AC_LANG compiler accepts $1], CACHEVAR, [
  ax_check_save_flags=$[]_AC_LANG_PREFIX[]FLAGS
  if test x"m4_case(_AC_LANG,
                     [C], [$GCC],
                     [C++], [$GXX],
                     [Fortran], [$GFC],
                     [Fortran 77], [$G77],
                     [Objective C], [$GOBJC],
                     [Objective C++], [$GOBJCXX],
                     [no])" = xyes ; then
    add_gnu_werror="-Werror"
  fi
  _AC_LANG_PREFIX[]FLAGS="$[]_AC_LANG_PREFIX[]FLAGS $4 $1 $add_gnu_werror"
  AC_COMPILE_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
    [AS_VAR_SET(CACHEVAR,[yes])],
    [AS_VAR_SET(CACHEVAR,[no])])
  _AC_LANG_PREFIX[]FLAGS=$ax_check_save_flags])
AS_VAR_IF(CACHEVAR,yes,
  [m4_default([$2], :)],
  [m4_default([$3], :)])
AS_VAR_POPDEF([CACHEVAR])dnl
])dnl AX_CHECK_COMPILE_FLAGS

# ===========================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_cxx_compile_stdcxx.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CXX_COMPILE_STDCXX(VERSION, [ext|noext], [mandatory|optional])
#
# DESCRIPTION
#
#   Check for baseline language coverage in the compiler for the specified
#   version of the C++ standard.  If necessary, add switches to CXX and
#   CXXCPP to enable support.  VERSION may be '11', '14', '17', '20', or
#   '23' for the respective C++ standard version.
#
#   The second argument, if specified, indicates whether you insist on an
#   extended mode (e.g. -std=gnu++11) or a strict conformance mode (e.g.
#   -std=c++11).  If neither is specified, you get whatever works, with
#   preference for no added switch, and then for an extended mode.
#
#   The third argument, if specified 'mandatory' or if left unspecified,
#   indicates that baseline support for the specified C++ standard is
#   required and that the macro should error out if no mode with that
#   support is found.  If specified 'optional', then configuration proceeds
#   regardless, after defining HAVE_CXX${VERSION} if and only if a
#   supporting mode is found.
#
# LICENSE
#
#   Copyright (c) 2008 Benjamin Kosnik <bkoz@redhat.com>
#   Copyright (c) 2012 Zack Weinberg <zackw@panix.com>
#   Copyright (c) 2013 Roy Stogner <roystgnr@ices.utexas.edu>
#   Copyright (c) 2014, 2015 Google Inc.; contributed by Alexey Sokolov <sokolov@google.com>
#   Copyright (c) 2015 Paul Norman <penorman@mac.com>
#   Copyright (c) 2015 Moritz Klammler <moritz@klammler.eu>
#   Copyright (c) 2016, 2018 Krzesimir Nowak <qdlacz@gmail.com>
#   Copyright (c) 2019 Enji Cooper <yaneurabeya@gmail.com>
#   Copyright (c) 2020 Jason Merrill <jason@redhat.com>
#   Copyright (c) 2021 Jörn Heusipp <osmanx@problemloesungsmaschine.de>
#   Copyright (c) 2015, 2022, 2023, 2024 Olly Betts
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 23

dnl  This macro is based on the code from the AX_CXX_COMPILE_STDCXX_11 macro
dnl  (serial version number 13).

AC_DEFUN([AX_CXX_COMPILE_STDCXX], [dnl
  m4_if([$1], [11], [ax_cxx_compile_alternatives="11 0x"],
        [$1], [14], [ax_cxx_compile_alternatives="14 1y"],
        [$1], [17], [ax_cxx_compile_alternatives="17 1z"],
        [$1], [20], [ax_cxx_compile_alternatives="20"],
        [$1], [23], [ax_cxx_compile_alternatives="23"],
        [m4_fatal([invalid first argument `$1' to AX_CXX_COMPILE_STDCXX])])dnl
  m4_if([$2], [], [],
        [$2], [ext], [],
        [$2], [noext], [],
        [m4_fatal([invalid second argument `$2' to AX_CXX_COMPILE_STDCXX])])dnl
  m4_if([$3], [], [ax_cxx_compile_cxx$1_required=true],
        [$3], [mandatory], [ax_cxx_compile_cxx$1_required=true],
        [$3], [optional], [ax_cxx_compile_cxx$1_required=false],
        [m4_fatal([invalid third argument `$3' to AX_CXX_COMPILE_STDCXX])])
  AC_LANG_PUSH([C++])dnl
  ac_success=no

  m4_if([$2], [], [dnl
    AC_CACHE_CHECK(whether $CXX supports C++$1 features by default,
		   ax_cv_cxx_compile_cxx$1,
      [AC_COMPILE_IFELSE([AC_LANG_SOURCE([_AX_CXX_COMPILE_STDCXX_testbody_$1])],
        [ax_cv_cxx_compile_cxx$1=yes],
        [ax_cv_cxx_compile_cxx$1=no])])
    if test x$ax_cv_cxx_compile_cxx$1 = xyes; then
      ac_success=yes
    fi])

  m4_if([$2], [noext], [dnl
  if test x$ac_success = xno; then
    for alternative in ${ax_cxx_compile_alternatives}; do
      switch="-std=gnu++${alternative}"
      cachevar=AS_TR_SH([ax_cv_cxx_compile_cxx$1_$switch])
      AC_CACHE_CHECK(whether $CXX supports C++$1 features with $switch,
                     $cachevar,
        [ac_save_CXX="$CXX"
         CXX="$CXX $switch"
         AC_COMPILE_IFELSE([AC_LANG_SOURCE([_AX_CXX_COMPILE_STDCXX_testbody_$1])],
          [eval $cachevar=yes],
          [eval $cachevar=no])
         CXX="$ac_save_CXX"])
      if eval test x\$$cachevar = xyes; then
        CXX="$CXX $switch"
        if test -n "$CXXCPP" ; then
          CXXCPP="$CXXCPP $switch"
        fi
        ac_success=yes
        break
      fi
    done
  fi])

  m4_if([$2], [ext], [dnl
  if test x$ac_success = xno; then
    dnl HP's aCC needs +std=c++11 according to:
    dnl http://h21007.www2.hp.com/portal/download/files/unprot/aCxx/PDF_Release_Notes/769149-001.pdf
    dnl Cray's crayCC needs "-h std=c++11"
    dnl MSVC needs -std:c++NN for C++17 and later (default is C++14)
    for alternative in ${ax_cxx_compile_alternatives}; do
      for switch in -std=c++${alternative} +std=c++${alternative} "-h std=c++${alternative}" MSVC; do
        if test x"$switch" = xMSVC; then
          dnl AS_TR_SH maps both `:` and `=` to `_` so -std:c++17 would collide
          dnl with -std=c++17.  We suffix the cache variable name with _MSVC to
          dnl avoid this.
          switch=-std:c++${alternative}
          cachevar=AS_TR_SH([ax_cv_cxx_compile_cxx$1_${switch}_MSVC])
        else
          cachevar=AS_TR_SH([ax_cv_cxx_compile_cxx$1_$switch])
        fi
        AC_CACHE_CHECK(whether $CXX supports C++$1 features with $switch,
                       $cachevar,
          [ac_save_CXX="$CXX"
           CXX="$CXX $switch"
           AC_COMPILE_IFELSE([AC_LANG_SOURCE([_AX_CXX_COMPILE_STDCXX_testbody_$1])],
            [eval $cachevar=yes],
            [eval $cachevar=no])
           CXX="$ac_save_CXX"])
        if eval test x\$$cachevar = xyes; then
          CXX="$CXX $switch"
          if test -n "$CXXCPP" ; then
            CXXCPP="$CXXCPP $switch"
          fi
          ac_success=yes
          break
        fi
      done
      if test x$ac_success = xyes; then
        break
      fi
    done
  fi])
  AC_LANG_POP([C++])
  if test x$ax_cxx_compile_cxx$1_required = xtrue; then
    if test x$ac_success = xno; then
      AC_MSG_ERROR([*** A compiler with support for C++$1 language features is required.])
    fi
  fi
  if test x$ac_success = xno; then
    HAVE_CXX$1=0
    AC_MSG_NOTICE([No compiler with C++$1 support was found])
  else
    HAVE_CXX$1=1
    AC_DEFINE(HAVE_CXX$1,1,
              [define if the compiler supports basic C++$1 syntax])
  fi
  AC_SUBST(HAVE_CXX$1)
])


dnl  Test body for checking C++11 support

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_11],
  [_AX_CXX_COMPILE_STDCXX_testbody_new_in_11]
)

dnl  Test body for checking C++14 support

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_14],
  [_AX_CXX_COMPILE_STDCXX_testbody_new_in_11
   _AX_CXX_COMPILE_STDCXX_testbody_new_in_14]
)

dnl  Test body for checking C++17 support

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_17],
  [_AX_CXX_COMPILE_STDCXX_testbody_new_in_11
   _AX_CXX_COMPILE_STDCXX_testbody_new_in_14
   _AX_CXX_COMPILE_STDCXX_testbody_new_in_17]
)

dnl  Test body for checking C++20 support

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_20],
  [_AX_CXX_COMPILE_STDCXX_testbody_new_in_11
   _AX_CXX_COMPILE_STDCXX_testbody_new_in_14
   _AX_CXX_COMPILE_STDCXX_testbody_new_in_17
   _AX_CXX_COMPILE_STDCXX_testbody_new_in_20]
)

dnl  Test body for checking C++23 support

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_23],
  _AX_CXX_COMPILE_STDCXX_testbody_new_in_11
  _AX_CXX_COMPILE_STDCXX_testbody_new_in_14
  _AX_CXX_COMPILE_STDCXX_testbody_new_in_17
  _AX_CXX_COMPILE_STDCXX_testbody_new_in_20
  _AX_CXX_COMPILE_STDCXX_testbody_new_in_23
)


dnl  Tests for new features in C++11

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_new_in_11], [[

// If the compiler admits that it is not ready for C++11, why torture it?
// Hopefully, this will speed up the test.

#ifndef __cplusplus

#error "This is not a C++ compiler"

// MSVC always sets __cplusplus to 199711L in older versions; newer versions
// only set it correctly if /Zc:__cplusplus is specified as well as a
// /std:c++NN switch:
//
// https://devblogs.microsoft.com/cppblog/msvc-now-correctly-reports-__cplusplus/
//
// The value __cplusplus ought to have is available in _MSVC_LANG since
// Visual Studio 2015 Update 3:
//
// https://learn.microsoft.com/en-us/cpp/preprocessor/predefined-macros
//
// This was also the first MSVC version to support C++14 so we can't use the
// value of either __cplusplus or _MSVC_LANG to quickly rule out MSVC having
// C++11 or C++14 support, but we can check _MSVC_LANG for C++17 and later.
#elif __cplusplus < 201103L && !defined _MSC_VER

#error "This is not a C++11 compiler"

#else

namespace cxx11
{

  namespace test_static_assert
  {

    template <typename T>
    struct check
    {
      static_assert(sizeof(int) <= sizeof(T), "not big enough");
    };

  }

  namespace test_final_override
  {

    struct Base
    {
      virtual ~Base() {}
      virtual void f() {}
    };

    struct Derived : public Base
    {
      virtual ~Derived() override {}
      virtual void f() override {}
    };

  }

  namespace test_double_right_angle_brackets
  {

    template < typename T >
    struct check {};

    typedef check<void> single_type;
    typedef check<check<void>> double_type;
    typedef check<check<check<void>>> triple_type;
    typedef check<check<check<check<void>>>> quadruple_type;

  }

  namespace test_decltype
  {

    int
    f()
    {
      int a = 1;
      decltype(a) b = 2;
      return a + b;
    }

  }

  namespace test_type_deduction
  {

    template < typename T1, typename T2 >
    struct is_same
    {
      static const bool value = false;
    };

    template < typename T >
    struct is_same<T, T>
    {
      static const bool value = true;
    };

    template < typename T1, typename T2 >
    auto
    add(T1 a1, T2 a2) -> decltype(a1 + a2)
    {
      return a1 + a2;
    }

    int
    test(const int c, volatile int v)
    {
      static_assert(is_same<int, decltype(0)>::value == true, "");
      static_assert(is_same<int, decltype(c)>::value == false, "");
      static_assert(is_same<int, decltype(v)>::value == false, "");
      auto ac = c;
      auto av = v;
      auto sumi = ac + av + 'x';
      auto sumf = ac + av + 1.0;
      static_assert(is_same<int, decltype(ac)>::value == true, "");
      static_assert(is_same<int, decltype(av)>::value == true, "");
      static_assert(is_same<int, decltype(sumi)>::value == true, "");
      static_assert(is_same<int, decltype(sumf)>::value == false, "");
      static_assert(is_same<int, decltype(add(c, v))>::value == true, "");
      return (sumf > 0.0) ? sumi : add(c, v);
    }

  }

  namespace test_noexcept
  {

    int f() { return 0; }
    int g() noexcept { return 0; }

    static_assert(noexcept(f()) == false, "");
    static_assert(noexcept(g()) == true, "");

  }

  namespace test_constexpr
  {

    template < typename CharT >
    unsigned long constexpr
    strlen_c_r(const CharT *const s, const unsigned long acc) noexcept
    {
      return *s ? strlen_c_r(s + 1, acc + 1) : acc;
    }

    template < typename CharT >
    unsigned long constexpr
    strlen_c(const CharT *const s) noexcept
    {
      return strlen_c_r(s, 0UL);
    }

    static_assert(strlen_c("") == 0UL, "");
    static_assert(strlen_c("1") == 1UL, "");
    static_assert(strlen_c("example") == 7UL, "");
    static_assert(strlen_c("another\0example") == 7UL, "");

  }

  namespace test_rvalue_references
  {

    template < int N >
    struct answer
    {
      static constexpr int value = N;
    };

    answer<1> f(int&)       { return answer<1>(); }
    answer<2> f(const int&) { return answer<2>(); }
    answer<3> f(int&&)      { return answer<3>(); }

    void
    test()
    {
      int i = 0;
      const int c = 0;
      static_assert(decltype(f(i))::value == 1, "");
      static_assert(decltype(f(c))::value == 2, "");
      static_assert(decltype(f(0))::value == 3, "");
    }

  }

  namespace test_uniform_initialization
  {

    struct test
    {
      static const int zero {};
      static const int one {1};
    };

    static_assert(test::zero == 0, "");
    static_assert(test::one == 1, "");

  }

  namespace test_lambdas
  {

    void
    test1()
    {
      auto lambda1 = [](){};
      auto lambda2 = lambda1;
      lambda1();
      lambda2();
    }

    int
    test2()
    {
      auto a = [](int i, int j){ return i + j; }(1, 2);
      auto b = []() -> int { return '0'; }();
      auto c = [=](){ return a + b; }();
      auto d = [&](){ return c; }();
      auto e = [a, &b](int x) mutable {
        const auto identity = [](int y){ return y; };
        for (auto i = 0; i < a; ++i)
          a += b--;
        return x + identity(a + b);
      }(0);
      return a + b + c + d + e;
    }

    int
    test3()
    {
      const auto nullary = [](){ return 0; };
      const auto unary = [](int x){ return x; };
      using nullary_t = decltype(nullary);
      using unary_t = decltype(unary);
      const auto higher1st = [](nullary_t f){ return f(); };
      const auto higher2nd = [unary](nullary_t f1){
        return [unary, f1](unary_t f2){ return f2(unary(f1())); };
      };
      return higher1st(nullary) + higher2nd(nullary)(unary);
    }

  }

  namespace test_variadic_templates
  {

    template <int...>
    struct sum;

    template <int N0, int... N1toN>
    struct sum<N0, N1toN...>
    {
      static constexpr auto value = N0 + sum<N1toN...>::value;
    };

    template <>
    struct sum<>
    {
      static constexpr auto value = 0;
    };

    static_assert(sum<>::value == 0, "");
    static_assert(sum<1>::value == 1, "");
    static_assert(sum<23>::value == 23, "");
    static_assert(sum<1, 2>::value == 3, "");
    static_assert(sum<5, 5, 11>::value == 21, "");
    static_assert(sum<2, 3, 5, 7, 11, 13>::value == 41, "");

  }

  // http://stackoverflow.com/questions/13728184/template-aliases-and-sfinae
  // Clang 3.1 fails with headers of libstd++ 4.8.3 when using std::function
  // because of this.
  namespace test_template_alias_sfinae
  {

    struct foo {};

    template<typename T>
    using member = typename T::member_type;

    template<typename T>
    void func(...) {}

    template<typename T>
    void func(member<T>*) {}

    void test();

    void test() { func<foo>(0); }

  }

}  // namespace cxx11

#endif  // __cplusplus >= 201103L

]])


dnl  Tests for new features in C++14

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_new_in_14], [[

// If the compiler admits that it is not ready for C++14, why torture it?
// Hopefully, this will speed up the test.

#ifndef __cplusplus

#error "This is not a C++ compiler"

#elif __cplusplus < 201402L && !defined _MSC_VER

#error "This is not a C++14 compiler"

#else

namespace cxx14
{

  namespace test_polymorphic_lambdas
  {

    int
    test()
    {
      const auto lambda = [](auto&&... args){
        const auto istiny = [](auto x){
          return (sizeof(x) == 1UL) ? 1 : 0;
        };
        const int aretiny[] = { istiny(args)... };
        return aretiny[0];
      };
      return lambda(1, 1L, 1.0f, '1');
    }

  }

  namespace test_binary_literals
  {

    constexpr auto ivii = 0b0000000000101010;
    static_assert(ivii == 42, "wrong value");

  }

  namespace test_generalized_constexpr
  {

    template < typename CharT >
    constexpr unsigned long
    strlen_c(const CharT *const s) noexcept
    {
      auto length = 0UL;
      for (auto p = s; *p; ++p)
        ++length;
      return length;
    }

    static_assert(strlen_c("") == 0UL, "");
    static_assert(strlen_c("x") == 1UL, "");
    static_assert(strlen_c("test") == 4UL, "");
    static_assert(strlen_c("another\0test") == 7UL, "");

  }

  namespace test_lambda_init_capture
  {

    int
    test()
    {
      auto x = 0;
      const auto lambda1 = [a = x](int b){ return a + b; };
      const auto lambda2 = [a = lambda1(x)](){ return a; };
      return lambda2();
    }

  }

  namespace test_digit_separators
  {

    constexpr auto ten_million = 100'000'000;
    static_assert(ten_million == 100000000, "");

  }

  namespace test_return_type_deduction
  {

    auto f(int& x) { return x; }
    decltype(auto) g(int& x) { return x; }

    template < typename T1, typename T2 >
    struct is_same
    {
      static constexpr auto value = false;
    };

    template < typename T >
    struct is_same<T, T>
    {
      static constexpr auto value = true;
    };

    int
    test()
    {
      auto x = 0;
      static_assert(is_same<int, decltype(f(x))>::value, "");
      static_assert(is_same<int&, decltype(g(x))>::value, "");
      return x;
    }

  }

}  // namespace cxx14

#endif  // __cplusplus >= 201402L

]])


dnl  Tests for new features in C++17

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_new_in_17], [[

// If the compiler admits that it is not ready for C++17, why torture it?
// Hopefully, this will speed up the test.

#ifndef __cplusplus

#error "This is not a C++ compiler"

#elif (defined _MSVC_LANG ? _MSVC_LANG : __cplusplus) < 201703L

#error "This is not a C++17 compiler"

#else

#include <initializer_list>
#include <utility>
#include <type_traits>

namespace cxx17
{

  namespace test_constexpr_lambdas
  {

    constexpr int foo = [](){return 42;}();

  }

  namespace test::nested_namespace::definitions
  {

  }

  namespace test_fold_expression
  {

    template<typename... Args>
    int multiply(Args... args)
    {
      return (args * ... * 1);
    }

    template<typename... Args>
    bool all(Args... args)
    {
      return (args && ...);
    }

  }

  namespace test_extended_static_assert
  {

    static_assert (true);

  }

  namespace test_auto_brace_init_list
  {

    auto foo = {5};
    auto bar {5};

    static_assert(std::is_same<std::initializer_list<int>, decltype(foo)>::value);
    static_assert(std::is_same<int, decltype(bar)>::value);
  }

  namespace test_typename_in_template_template_parameter
  {

    template<template<typename> typename X> struct D;

  }

  namespace test_fallthrough_nodiscard_maybe_unused_attributes
  {

    int f1()
    {
      return 42;
    }

    [[nodiscard]] int f2()
    {
      [[maybe_unused]] auto unused = f1();

      switch (f1())
      {
      case 17:
        f1();
        [[fallthrough]];
      case 42:
        f1();
      }
      return f1();
    }

  }

  namespace test_extended_aggregate_initialization
  {

    struct base1
    {
      int b1, b2 = 42;
    };

    struct base2
    {
      base2() {
        b3 = 42;
      }
      int b3;
    };

    struct derived : base1, base2
    {
        int d;
    };

    derived d1 {{1, 2}, {}, 4};  // full initialization
    derived d2 {{}, {}, 4};      // value-initialized bases

  }

  namespace test_general_range_based_for_loop
  {

    struct iter
    {
      int i;

      int& operator* ()
      {
        return i;
      }

      const int& operator* () const
      {
        return i;
      }

      iter& operator++()
      {
        ++i;
        return *this;
      }
    };

    struct sentinel
    {
      int i;
    };

    bool operator== (const iter& i, const sentinel& s)
    {
      return i.i == s.i;
    }

    bool operator!= (const iter& i, const sentinel& s)
    {
      return !(i == s);
    }

    struct range
    {
      iter begin() const
      {
        return {0};
      }

      sentinel end() const
      {
        return {5};
      }
    };

    void f()
    {
      range r {};

      for (auto i : r)
      {
        [[maybe_unused]] auto v = i;
      }
    }

  }

  namespace test_lambda_capture_asterisk_this_by_value
  {

    struct t
    {
      int i;
      int foo()
      {
        return [*this]()
        {
          return i;
        }();
      }
    };

  }

  namespace test_enum_class_construction
  {

    enum class byte : unsigned char
    {};

    byte foo {42};

  }

  namespace test_constexpr_if
  {

    template <bool cond>
    int f ()
    {
      if constexpr(cond)
      {
        return 13;
      }
      else
      {
        return 42;
      }
    }

  }

  namespace test_selection_statement_with_initializer
  {

    int f()
    {
      return 13;
    }

    int f2()
    {
      if (auto i = f(); i > 0)
      {
        return 3;
      }

      switch (auto i = f(); i + 4)
      {
      case 17:
        return 2;

      default:
        return 1;
      }
    }

  }

  namespace test_template_argument_deduction_for_class_templates
  {

    template <typename T1, typename T2>
    struct pair
    {
      pair (T1 p1, T2 p2)
        : m1 {p1},
          m2 {p2}
      {}

      T1 m1;
      T2 m2;
    };

    void f()
    {
      [[maybe_unused]] auto p = pair{13, 42u};
    }

  }

  namespace test_non_type_auto_template_parameters
  {

    template <auto n>
    struct B
    {};

    B<5> b1;
    B<'a'> b2;

  }

  namespace test_structured_bindings
  {

    int arr[2] = { 1, 2 };
    std::pair<int, int> pr = { 1, 2 };

    auto f1() -> int(&)[2]
    {
      return arr;
    }

    auto f2() -> std::pair<int, int>&
    {
      return pr;
    }

    struct S
    {
      int x1 : 2;
      volatile double y1;
    };

    S f3()
    {
      return {};
    }

    auto [ x1, y1 ] = f1();
    auto& [ xr1, yr1 ] = f1();
    auto [ x2, y2 ] = f2();
    auto& [ xr2, yr2 ] = f2();
    const auto [ x3, y3 ] = f3();

  }

  namespace test_exception_spec_type_system
  {

    struct Good {};
    struct Bad {};

    void g1() noexcept;
    void g2();

    template<typename T>
    Bad
    f(T*, T*);

    template<typename T1, typename T2>
    Good
    f(T1*, T2*);

    static_assert (std::is_same_v<Good, decltype(f(g1, g2))>);

  }

  namespace test_inline_variables
  {

    template<class T> void f(T)
    {}

    template<class T> inline T g(T)
    {
      return T{};
    }

    template<> inline void f<>(int)
    {}

    template<> int g<>(int)
    {
      return 5;
    }

  }

}  // namespace cxx17

#endif  // (defined _MSVC_LANG ? _MSVC_LANG : __cplusplus) < 201703L

]])


dnl  Tests for new features in C++20

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_new_in_20], [[

#ifndef __cplusplus

#error "This is not a C++ compiler"

#elif (defined _MSVC_LANG ? _MSVC_LANG : __cplusplus) < 202002L

#error "This is not a C++20 compiler"

#else

#include <version>

namespace cxx20
{

// As C++20 supports feature test macros in the standard, there is no
// immediate need to actually test for feature availability on the
// Autoconf side.

}  // namespace cxx20

#endif  // (defined _MSVC_LANG ? _MSVC_LANG : __cplusplus) < 202002L

]])


dnl  Tests for new features in C++23

m4_define([_AX_CXX_COMPILE_STDCXX_testbody_new_in_23], [[

#ifndef __cplusplus

#error "This is not a C++ compiler"

#elif (defined _MSVC_LANG ? _MSVC_LANG : __cplusplus) < 202302L

#error "This is not a C++23 compiler"

#else

#include <version>

namespace cxx23
{

// As C++23 supports feature test macros in the standard, there is no
// immediate need to actually test for feature availability on the
// Autoconf side.

}  // namespace cxx23

#endif  // (defined _MSVC_LANG ? _MSVC_LANG : __cplusplus) < 202302L

]])

# =============================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_cxx_compile_stdcxx_11.html
# =============================================================================
#
# SYNOPSIS
#
#   AX_CXX_COMPILE_STDCXX_11([ext|noext], [mandatory|optional])
#
# DESCRIPTION
#
#   Check for baseline language coverage in the compiler for the C++11
#   standard; if necessary, add switches to CXX and CXXCPP to enable
#   support.
#
#   This macro is a convenience alias for calling the AX_CXX_COMPILE_STDCXX
#   macro with the version set to C++11.  The two optional arguments are
#   forwarded literally as the second and third argument respectively.
#   Please see the documentation for the AX_CXX_COMPILE_STDCXX macro for
#   more information.  If you want to use this macro, you also need to
#   download the ax_cxx_compile_stdcxx.m4 file.
#
# LICENSE
#
#   Copyright (c) 2008 Benjamin Kosnik <bkoz@redhat.com>
#   Copyright (c) 2012 Zack Weinberg <zackw@panix.com>
#   Copyright (c) 2013 Roy Stogner <roystgnr@ices.utexas.edu>
#   Copyright (c) 2014, 2015 Google Inc.; contributed by Alexey Sokolov <sokolov@google.com>
#   Copyright (c) 2015 Paul Norman <penorman@mac.com>
#   Copyright (c) 2015 Moritz Klammler <moritz@klammler.eu>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 18

AX_REQUIRE_DEFINED([AX_CXX_COMPILE_STDCXX])
AC_DEFUN([AX_CXX_COMPILE_STDCXX_11], [AX_CXX_COMPILE_STDCXX([11], [$1], [$2])])

# =============================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_cxx_compile_stdcxx_14.html
# =============================================================================
#
# SYNOPSIS
#
#   AX_CXX_COMPILE_STDCXX_14([ext|noext], [mandatory|optional])
#
# DESCRIPTION
#
#   Check for baseline language coverage in the compiler for the C++14
#   standard; if necessary, add switches to CXX and CXXCPP to enable
#   support.
#
#   This macro is a convenience alias for calling the AX_CXX_COMPILE_STDCXX
#   macro with the version set to C++14.  The two optional arguments are
#   forwarded literally as the second and third argument respectively.
#   Please see the documentation for the AX_CXX_COMPILE_STDCXX macro for
#   more information.  If you want to use this macro, you also need to
#   download the ax_cxx_compile_stdcxx.m4 file.
#
# LICENSE
#
#   Copyright (c) 2015 Moritz Klammler <moritz@klammler.eu>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 5

AX_REQUIRE_DEFINED([AX_CXX_COMPILE_STDCXX])
AC_DEFUN([AX_CXX_COMPILE_STDCXX_14], [AX_CXX_COMPILE_STDCXX([14], [$1], [$2])])

# =============================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_cxx_compile_stdcxx_17.html
# =============================================================================
#
# SYNOPSIS
#
#   AX_CXX_COMPILE_STDCXX_17([ext|noext], [mandatory|optional])
#
# DESCRIPTION
#
#   Check for baseline language coverage in the compiler for the C++17
#   standard; if necessary, add switches to CXX and CXXCPP to enable
#   support.
#
#   This macro is a convenience alias for calling the AX_CXX_COMPILE_STDCXX
#   macro with the version set to C++17.  The two optional arguments are
#   forwarded literally as the second and third argument respectively.
#   Please see the documentation for the AX_CXX_COMPILE_STDCXX macro for
#   more information.  If you want to use this macro, you also need to
#   download the ax_cxx_compile_stdcxx.m4 file.
#
# LICENSE
#
#   Copyright (c) 2015 Moritz Klammler <moritz@klammler.eu>
#   Copyright (c) 2016 Krzesimir Nowak <qdlacz@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 2

AX_REQUIRE_DEFINED([AX_CXX_COMPILE_STDCXX])
AC_DEFUN([AX_CXX_COMPILE_STDCXX_17], [AX_CXX_COMPILE_STDCXX([17], [$1], [$2])])

# ===========================================================================
#   https://www.gnu.org/software/autoconf-archive/ax_prog_cc_for_build.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_PROG_CC_FOR_BUILD
#
# DESCRIPTION
#
#   This macro searches for a C compiler that generates native executables,
#   that is a C compiler that surely is not a cross-compiler. This can be
#   useful if you have to generate source code at compile-time like for
#   example GCC does.
#
#   The macro sets the CC_FOR_BUILD and CPP_FOR_BUILD macros to anything
#   needed to compile or link (CC_FOR_BUILD) and preprocess (CPP_FOR_BUILD).
#   The value of these variables can be overridden by the user by specifying
#   a compiler with an environment variable (like you do for standard CC).
#
#   It also sets BUILD_EXEEXT and BUILD_OBJEXT to the executable and object
#   file extensions for the build platform, and GCC_FOR_BUILD to `yes' if
#   the compiler we found is GCC. All these variables but GCC_FOR_BUILD are
#   substituted in the Makefile.
#
# LICENSE
#
#   Copyright (c) 2008 Paolo Bonzini <bonzini@gnu.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 22

AU_ALIAS([AC_PROG_CC_FOR_BUILD], [AX_PROG_CC_FOR_BUILD])
AC_DEFUN([AX_PROG_CC_FOR_BUILD], [dnl
AC_REQUIRE([AC_PROG_CC])dnl
AC_REQUIRE([AC_PROG_CPP])dnl
AC_REQUIRE([AC_CANONICAL_BUILD])dnl

dnl Use the standard macros, but make them use other variable names
dnl
pushdef([ac_cv_prog_CPP], ac_cv_build_prog_CPP)dnl
pushdef([ac_cv_prog_cc_c89], ac_cv_build_prog_cc_c89)dnl
pushdef([ac_cv_prog_cc_c99], ac_cv_build_prog_cc_c99)dnl
pushdef([ac_cv_prog_cc_c11], ac_cv_build_prog_cc_c11)dnl
pushdef([ac_cv_prog_gcc], ac_cv_build_prog_gcc)dnl
pushdef([ac_cv_prog_cc_works], ac_cv_build_prog_cc_works)dnl
pushdef([ac_cv_prog_cc_cross], ac_cv_build_prog_cc_cross)dnl
pushdef([ac_cv_prog_cc_g], ac_cv_build_prog_cc_g)dnl
pushdef([ac_cv_c_compiler_gnu], ac_cv_build_c_compiler_gnu)dnl
pushdef([ac_cv_exeext], ac_cv_build_exeext)dnl
pushdef([ac_cv_objext], ac_cv_build_objext)dnl
pushdef([ac_exeext], ac_build_exeext)dnl
pushdef([ac_objext], ac_build_objext)dnl
pushdef([CC], CC_FOR_BUILD)dnl
pushdef([CPP], CPP_FOR_BUILD)dnl
pushdef([GCC], GCC_FOR_BUILD)dnl
pushdef([CFLAGS], CFLAGS_FOR_BUILD)dnl
pushdef([CPPFLAGS], CPPFLAGS_FOR_BUILD)dnl
pushdef([EXEEXT], BUILD_EXEEXT)dnl
pushdef([LDFLAGS], LDFLAGS_FOR_BUILD)dnl
pushdef([OBJEXT], BUILD_OBJEXT)dnl
pushdef([host], build)dnl
pushdef([host_alias], build_alias)dnl
pushdef([host_cpu], build_cpu)dnl
pushdef([host_vendor], build_vendor)dnl
pushdef([host_os], build_os)dnl
pushdef([ac_cv_host], ac_cv_build)dnl
pushdef([ac_cv_host_alias], ac_cv_build_alias)dnl
pushdef([ac_cv_host_cpu], ac_cv_build_cpu)dnl
pushdef([ac_cv_host_vendor], ac_cv_build_vendor)dnl
pushdef([ac_cv_host_os], ac_cv_build_os)dnl
pushdef([ac_tool_prefix], ac_build_tool_prefix)dnl
pushdef([am_cv_CC_dependencies_compiler_type], am_cv_build_CC_dependencies_compiler_type)dnl
pushdef([am_cv_prog_cc_c_o], am_cv_build_prog_cc_c_o)dnl
pushdef([cross_compiling], cross_compiling_build)dnl

cross_compiling_build=no

ac_build_tool_prefix=
AS_IF([test -n "$build"],      [ac_build_tool_prefix="$build-"],
      [test -n "$build_alias"],[ac_build_tool_prefix="$build_alias-"])

AC_LANG_PUSH([C])

dnl The pushdef([ac_cv_c_compiler_gnu], ...) currently does not cover
dnl the use of this variable in _AC_LANG_COMPILER_GNU called by
dnl AC_PROG_CC. Unset this cache variable temporarily as a workaround.
was_set_c_compiler_gnu=${[ac_cv_c_compiler_gnu]+y}
AS_IF([test ${was_set_c_compiler_gnu}],
    [saved_c_compiler_gnu=$[ac_cv_c_compiler_gnu]
    AS_UNSET([[ac_cv_c_compiler_gnu]])])

AC_PROG_CC

dnl Restore ac_cv_c_compiler_gnu
AS_IF([test ${was_set_c_compiler_gnu}],
  [[ac_cv_c_compiler_gnu]=$[saved_c_compiler_gnu]])

_AC_COMPILER_EXEEXT
_AC_COMPILER_OBJEXT
AC_PROG_CPP

dnl Restore the old definitions
dnl
popdef([cross_compiling])dnl
popdef([am_cv_prog_cc_c_o])dnl
popdef([am_cv_CC_dependencies_compiler_type])dnl
popdef([ac_tool_prefix])dnl
popdef([ac_cv_host_os])dnl
popdef([ac_cv_host_vendor])dnl
popdef([ac_cv_host_cpu])dnl
popdef([ac_cv_host_alias])dnl
popdef([ac_cv_host])dnl
popdef([host_os])dnl
popdef([host_vendor])dnl
popdef([host_cpu])dnl
popdef([host_alias])dnl
popdef([host])dnl
popdef([OBJEXT])dnl
popdef([LDFLAGS])dnl
popdef([EXEEXT])dnl
popdef([CPPFLAGS])dnl
popdef([CFLAGS])dnl
popdef([GCC])dnl
popdef([CPP])dnl
popdef([CC])dnl
popdef([ac_objext])dnl
popdef([ac_exeext])dnl
popdef([ac_cv_objext])dnl
popdef([ac_cv_exeext])dnl
popdef([ac_cv_c_compiler_gnu])dnl
popdef([ac_cv_prog_cc_g])dnl
popdef([ac_cv_prog_cc_cross])dnl
popdef([ac_cv_prog_cc_works])dnl
popdef([ac_cv_prog_cc_c89])dnl
popdef([ac_cv_prog_gcc])dnl
popdef([ac_cv_prog_CPP])dnl

dnl restore global variables ac_ext, ac_cpp, ac_compile,
dnl ac_link, ac_compiler_gnu (dependent on the current
dnl language after popping):
AC_LANG_POP([C])

dnl Finally, set Makefile variables
dnl
AC_SUBST(BUILD_EXEEXT)dnl
AC_SUBST(BUILD_OBJEXT)dnl
AC_SUBST([CFLAGS_FOR_BUILD])dnl
AC_SUBST([CPPFLAGS_FOR_BUILD])dnl
AC_SUBST([LDFLAGS_FOR_BUILD])dnl
])

# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_require_defined.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_REQUIRE_DEFINED(MACRO)
#
# DESCRIPTION
#
#   AX_REQUIRE_DEFINED is a simple helper for making sure other macros have
#   been defined and thus are available for use.  This avoids random issues
#   where a macro isn't expanded.  Instead the configure script emits a
#   non-fatal:
#
#     ./configure: line 1673: AX_CFLAGS_WARN_ALL: command not found
#
#   It's like AC_REQUIRE except it doesn't expand the required macro.
#
#   Here's an example:
#
#     AX_REQUIRE_DEFINED([AX_CHECK_LINK_FLAG])
#
# LICENSE
#
#   Copyright (c) 2014 Mike Frysinger <vapier@gentoo.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 2

AC_DEFUN([AX_REQUIRE_DEFINED], [dnl
  m4_ifndef([$1], [m4_fatal([macro ]$1[ is not defined; is a m4 file missing?])])
])dnl AX_REQUIRE_DEFINED

# ===========================================================================
#      https://www.gnu.org/software/autoconf-archive/ax_with_curses.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_WITH_CURSES
#
# DESCRIPTION
#
#   This macro checks whether a SysV or X/Open-compatible Curses library is
#   present, along with the associated header file.  The NcursesW
#   (wide-character) library is searched for first, followed by Ncurses,
#   then the system-default plain Curses.  The first library found is the
#   one returned. Finding libraries will first be attempted by using
#   pkg-config, and should the pkg-config files not be available, will
#   fallback to combinations of known flags itself.
#
#   The following options are understood: --with-ncursesw, --with-ncurses,
#   --without-ncursesw, --without-ncurses.  The "--with" options force the
#   macro to use that particular library, terminating with an error if not
#   found.  The "--without" options simply skip the check for that library.
#   The effect on the search pattern is:
#
#     (no options)                           - NcursesW, Ncurses, Curses
#     --with-ncurses     --with-ncursesw     - NcursesW only [*]
#     --without-ncurses  --with-ncursesw     - NcursesW only [*]
#                        --with-ncursesw     - NcursesW only [*]
#     --with-ncurses     --without-ncursesw  - Ncurses only [*]
#     --with-ncurses                         - NcursesW, Ncurses [**]
#     --without-ncurses  --without-ncursesw  - Curses only
#                        --without-ncursesw  - Ncurses, Curses
#     --without-ncurses                      - NcursesW, Curses
#
#   [*]  If the library is not found, abort the configure script.
#
#   [**] If the second library (Ncurses) is not found, abort configure.
#
#   The following preprocessor symbols may be defined by this macro if the
#   appropriate conditions are met:
#
#     HAVE_CURSES             - if any SysV or X/Open Curses library found
#     HAVE_CURSES_ENHANCED    - if library supports X/Open Enhanced functions
#     HAVE_CURSES_COLOR       - if library supports color (enhanced functions)
#     HAVE_CURSES_OBSOLETE    - if library supports certain obsolete features
#     HAVE_NCURSESW           - if NcursesW (wide char) library is to be used
#     HAVE_NCURSES            - if the Ncurses library is to be used
#
#     HAVE_CURSES_H           - if <curses.h> is present and should be used
#     HAVE_NCURSESW_H         - if <ncursesw.h> should be used
#     HAVE_NCURSES_H          - if <ncurses.h> should be used
#     HAVE_NCURSESW_CURSES_H  - if <ncursesw/curses.h> should be used
#     HAVE_NCURSES_CURSES_H   - if <ncurses/curses.h> should be used
#
#   (These preprocessor symbols are discussed later in this document.)
#
#   The following output variables are defined by this macro; they are
#   precious and may be overridden on the ./configure command line:
#
#     CURSES_LIBS  - library to add to xxx_LDADD
#     CURSES_CFLAGS  - include paths to add to xxx_CPPFLAGS
#
#   In previous versions of this macro, the flags CURSES_LIB and
#   CURSES_CPPFLAGS were defined. These have been renamed, in keeping with
#   AX_WITH_CURSES's close bigger brother, PKG_CHECK_MODULES, which should
#   eventually supersede the use of AX_WITH_CURSES. Neither the library
#   listed in CURSES_LIBS, nor the flags in CURSES_CFLAGS are added to LIBS,
#   respectively CPPFLAGS, by default. You need to add both to the
#   appropriate xxx_LDADD/xxx_CPPFLAGS line in your Makefile.am. For
#   example:
#
#     prog_LDADD = @CURSES_LIBS@
#     prog_CPPFLAGS = @CURSES_CFLAGS@
#
#   If CURSES_LIBS is set on the configure command line (such as by running
#   "./configure CURSES_LIBS=-lmycurses"), then the only header searched for
#   is <curses.h>. If the user needs to specify an alternative path for a
#   library (such as for a non-standard NcurseW), the user should use the
#   LDFLAGS variable.
#
#   The following shell variables may be defined by this macro:
#
#     ax_cv_curses           - set to "yes" if any Curses library found
#     ax_cv_curses_enhanced  - set to "yes" if Enhanced functions present
#     ax_cv_curses_color     - set to "yes" if color functions present
#     ax_cv_curses_obsolete  - set to "yes" if obsolete features present
#
#     ax_cv_ncursesw      - set to "yes" if NcursesW library found
#     ax_cv_ncurses       - set to "yes" if Ncurses library found
#     ax_cv_plaincurses   - set to "yes" if plain Curses library found
#     ax_cv_curses_which  - set to "ncursesw", "ncurses", "plaincurses" or "no"
#
#   These variables can be used in your configure.ac to determine the level
#   of support you need from the Curses library.  For example, if you must
#   have either Ncurses or NcursesW, you could include:
#
#     AX_WITH_CURSES
#     if test "x$ax_cv_ncursesw" != xyes && test "x$ax_cv_ncurses" != xyes; then
#         AC_MSG_ERROR([requires either NcursesW or Ncurses library])
#     fi
#
#   If any Curses library will do (but one must be present and must support
#   color), you could use:
#
#     AX_WITH_CURSES
#     if test "x$ax_cv_curses" != xyes || test "x$ax_cv_curses_color" != xyes; then
#         AC_MSG_ERROR([requires an X/Open-compatible Curses library with color])
#     fi
#
#   Certain preprocessor symbols and shell variables defined by this macro
#   can be used to determine various features of the Curses library.  In
#   particular, HAVE_CURSES and ax_cv_curses are defined if the Curses
#   library found conforms to the traditional SysV and/or X/Open Base Curses
#   definition.  Any working Curses library conforms to this level.
#
#   HAVE_CURSES_ENHANCED and ax_cv_curses_enhanced are defined if the
#   library supports the X/Open Enhanced Curses definition.  In particular,
#   the wide-character types attr_t, cchar_t and wint_t, the functions
#   wattr_set() and wget_wch() and the macros WA_NORMAL and _XOPEN_CURSES
#   are checked.  The Ncurses library does NOT conform to this definition,
#   although NcursesW does.
#
#   HAVE_CURSES_COLOR and ax_cv_curses_color are defined if the library
#   supports color functions and macros such as COLOR_PAIR, A_COLOR,
#   COLOR_WHITE, COLOR_RED and init_pair().  These are NOT part of the
#   X/Open Base Curses definition, but are part of the Enhanced set of
#   functions.  The Ncurses library DOES support these functions, as does
#   NcursesW.
#
#   HAVE_CURSES_OBSOLETE and ax_cv_curses_obsolete are defined if the
#   library supports certain features present in SysV and BSD Curses but not
#   defined in the X/Open definition.  In particular, the functions
#   getattrs(), getcurx() and getmaxx() are checked.
#
#   To use the HAVE_xxx_H preprocessor symbols, insert the following into
#   your system.h (or equivalent) header file:
#
#     #if defined HAVE_NCURSESW_CURSES_H
#     #  include <ncursesw/curses.h>
#     #elif defined HAVE_NCURSESW_H
#     #  include <ncursesw.h>
#     #elif defined HAVE_NCURSES_CURSES_H
#     #  include <ncurses/curses.h>
#     #elif defined HAVE_NCURSES_H
#     #  include <ncurses.h>
#     #elif defined HAVE_CURSES_H
#     #  include <curses.h>
#     #else
#     #  error "SysV or X/Open-compatible Curses header file required"
#     #endif
#
#   For previous users of this macro: you should not need to change anything
#   in your configure.ac or Makefile.am, as the previous (serial 10)
#   semantics are still valid.  However, you should update your system.h (or
#   equivalent) header file to the fragment shown above. You are encouraged
#   also to make use of the extended functionality provided by this version
#   of AX_WITH_CURSES, as well as in the additional macros
#   AX_WITH_CURSES_PANEL, AX_WITH_CURSES_MENU and AX_WITH_CURSES_FORM.
#
# LICENSE
#
#   Copyright (c) 2009 Mark Pulford <mark@kyne.com.au>
#   Copyright (c) 2009 Damian Pietras <daper@daper.net>
#   Copyright (c) 2012 Reuben Thomas <rrt@sc3d.org>
#   Copyright (c) 2011 John Zaitseff <J.Zaitseff@zap.org.au>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <https://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 18

# internal function to factorize common code that is used by both ncurses
# and ncursesw
AC_DEFUN([_FIND_CURSES_FLAGS], [
    AC_MSG_CHECKING([for $1 via pkg-config])

    AX_REQUIRE_DEFINED([PKG_CHECK_EXISTS])
    _PKG_CONFIG([_ax_cv_$1_libs], [libs], [$1])
    _PKG_CONFIG([_ax_cv_$1_cppflags], [cflags], [$1])

    AS_IF([test "x$pkg_failed" = "xyes" || test "x$pkg_failed" = "xuntried"],[
        AC_MSG_RESULT([no])
        # No suitable .pc file found, have to find flags via fallback
        AC_CACHE_CHECK([for $1 via fallback], [ax_cv_$1], [
            AS_ECHO()
            pkg_cv__ax_cv_$1_libs="-l$1"
            pkg_cv__ax_cv_$1_cppflags="-D_GNU_SOURCE $CURSES_CFLAGS"
            LIBS="$ax_saved_LIBS $pkg_cv__ax_cv_$1_libs"
            CPPFLAGS="$ax_saved_CPPFLAGS $pkg_cv__ax_cv_$1_cppflags"

            AC_MSG_CHECKING([for initscr() with $pkg_cv__ax_cv_$1_libs])
            AC_LINK_IFELSE([AC_LANG_CALL([], [initscr])],
                [
                    AC_MSG_RESULT([yes])
                    AC_MSG_CHECKING([for nodelay() with $pkg_cv__ax_cv_$1_libs])
                    AC_LINK_IFELSE([AC_LANG_CALL([], [nodelay])],[
                        ax_cv_$1=yes
                        ],[
                        AC_MSG_RESULT([no])
                        m4_if(
                            [$1],[ncursesw],[pkg_cv__ax_cv_$1_libs="$pkg_cv__ax_cv_$1_libs -ltinfow"],
                            [$1],[ncurses],[pkg_cv__ax_cv_$1_libs="$pkg_cv__ax_cv_$1_libs -ltinfo"]
                        )
                        LIBS="$ax_saved_LIBS $pkg_cv__ax_cv_$1_libs"

                        AC_MSG_CHECKING([for nodelay() with $pkg_cv__ax_cv_$1_libs])
                        AC_LINK_IFELSE([AC_LANG_CALL([], [nodelay])],[
                            ax_cv_$1=yes
                            ],[
                            ax_cv_$1=no
                        ])
                    ])
                ],[
                    ax_cv_$1=no
            ])
        ])
        ],[
        AC_MSG_RESULT([yes])
        # Found .pc file, using its information
        LIBS="$ax_saved_LIBS $pkg_cv__ax_cv_$1_libs"
        CPPFLAGS="$ax_saved_CPPFLAGS $pkg_cv__ax_cv_$1_cppflags"
        ax_cv_$1=yes
    ])
])

AU_ALIAS([MP_WITH_CURSES], [AX_WITH_CURSES])
AC_DEFUN([AX_WITH_CURSES], [
    AC_ARG_VAR([CURSES_LIBS], [linker library for Curses, e.g. -lcurses])
    AC_ARG_VAR([CURSES_CFLAGS], [preprocessor flags for Curses, e.g. -I/usr/include/ncursesw])
    AC_ARG_WITH([ncurses], [AS_HELP_STRING([--with-ncurses],
        [force the use of Ncurses or NcursesW])],
        [], [with_ncurses=check])
    AC_ARG_WITH([ncursesw], [AS_HELP_STRING([--without-ncursesw],
        [do not use NcursesW (wide character support)])],
        [], [with_ncursesw=check])

    ax_saved_LIBS=$LIBS
    ax_saved_CPPFLAGS=$CPPFLAGS

    AS_IF([test "x$with_ncurses" = xyes || test "x$with_ncursesw" = xyes],
        [ax_with_plaincurses=no], [ax_with_plaincurses=check])

    ax_cv_curses_which=no

    # Test for NcursesW
    AS_IF([test "x$CURSES_LIBS" = x && test "x$with_ncursesw" != xno], [
        _FIND_CURSES_FLAGS([ncursesw])

        AS_IF([test "x$ax_cv_ncursesw" = xno && test "x$with_ncursesw" = xyes], [
            AC_MSG_ERROR([--with-ncursesw specified but could not find NcursesW library])
        ])

        AS_IF([test "x$ax_cv_ncursesw" = xyes], [
            ax_cv_curses=yes
            ax_cv_curses_which=ncursesw
            CURSES_LIBS="$pkg_cv__ax_cv_ncursesw_libs"
            CURSES_CFLAGS="$pkg_cv__ax_cv_ncursesw_cppflags"
            AC_DEFINE([HAVE_NCURSESW], [1], [Define to 1 if the NcursesW library is present])
            AC_DEFINE([HAVE_CURSES],   [1], [Define to 1 if a SysV or X/Open compatible Curses library is present])

            AC_CACHE_CHECK([for working ncursesw/curses.h], [ax_cv_header_ncursesw_curses_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@define _XOPEN_SOURCE_EXTENDED 1
                        @%:@include <ncursesw/curses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        attr_t d = WA_NORMAL;
                        cchar_t e;
                        wint_t f;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                        wattr_set(stdscr, d, 0, NULL);
                        wget_wch(stdscr, &f);
                    ]])],
                    [ax_cv_header_ncursesw_curses_h=yes],
                    [ax_cv_header_ncursesw_curses_h=no])
            ])
            AS_IF([test "x$ax_cv_header_ncursesw_curses_h" = xyes], [
                ax_cv_curses_enhanced=yes
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_ENHANCED],   [1], [Define to 1 if library supports X/Open Enhanced functions])
                AC_DEFINE([HAVE_CURSES_COLOR],      [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE],   [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSESW_CURSES_H], [1], [Define to 1 if <ncursesw/curses.h> is present])
            ])

            AC_CACHE_CHECK([for working ncursesw.h], [ax_cv_header_ncursesw_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@define _XOPEN_SOURCE_EXTENDED 1
                        @%:@include <ncursesw.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        attr_t d = WA_NORMAL;
                        cchar_t e;
                        wint_t f;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                        wattr_set(stdscr, d, 0, NULL);
                        wget_wch(stdscr, &f);
                    ]])],
                    [ax_cv_header_ncursesw_h=yes],
                    [ax_cv_header_ncursesw_h=no])
            ])
            AS_IF([test "x$ax_cv_header_ncursesw_h" = xyes], [
                ax_cv_curses_enhanced=yes
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_ENHANCED], [1], [Define to 1 if library supports X/Open Enhanced functions])
                AC_DEFINE([HAVE_CURSES_COLOR],    [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE], [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSESW_H],      [1], [Define to 1 if <ncursesw.h> is present])
            ])

            AC_CACHE_CHECK([for working ncurses.h], [ax_cv_header_ncurses_h_with_ncursesw], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@define _XOPEN_SOURCE_EXTENDED 1
                        @%:@include <ncurses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        attr_t d = WA_NORMAL;
                        cchar_t e;
                        wint_t f;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                        wattr_set(stdscr, d, 0, NULL);
                        wget_wch(stdscr, &f);
                    ]])],
                    [ax_cv_header_ncurses_h_with_ncursesw=yes],
                    [ax_cv_header_ncurses_h_with_ncursesw=no])
            ])
            AS_IF([test "x$ax_cv_header_ncurses_h_with_ncursesw" = xyes], [
                ax_cv_curses_enhanced=yes
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_ENHANCED], [1], [Define to 1 if library supports X/Open Enhanced functions])
                AC_DEFINE([HAVE_CURSES_COLOR],    [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE], [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSES_H],       [1], [Define to 1 if <ncurses.h> is present])
            ])

            AS_IF([test "x$ax_cv_header_ncursesw_curses_h" = xno && test "x$ax_cv_header_ncursesw_h" = xno && test "x$ax_cv_header_ncurses_h_with_ncursesw" = xno], [
                AC_MSG_WARN([could not find a working ncursesw/curses.h, ncursesw.h or ncurses.h])
            ])
        ])
    ])
    unset pkg_cv__ax_cv_ncursesw_libs
    unset pkg_cv__ax_cv_ncursesw_cppflags

    # Test for Ncurses
    AS_IF([test "x$CURSES_LIBS" = x && test "x$with_ncurses" != xno && test "x$ax_cv_curses_which" = xno], [
        _FIND_CURSES_FLAGS([ncurses])

        AS_IF([test "x$ax_cv_ncurses" = xno && test "x$with_ncurses" = xyes], [
            AC_MSG_ERROR([--with-ncurses specified but could not find Ncurses library])
        ])

        AS_IF([test "x$ax_cv_ncurses" = xyes], [
            ax_cv_curses=yes
            ax_cv_curses_which=ncurses
            CURSES_LIBS="$pkg_cv__ax_cv_ncurses_libs"
            CURSES_CFLAGS="$pkg_cv__ax_cv_ncurses_cppflags"
            AC_DEFINE([HAVE_NCURSES], [1], [Define to 1 if the Ncurses library is present])
            AC_DEFINE([HAVE_CURSES],  [1], [Define to 1 if a SysV or X/Open compatible Curses library is present])

            AC_CACHE_CHECK([for working ncurses/curses.h], [ax_cv_header_ncurses_curses_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@include <ncurses/curses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                    ]])],
                    [ax_cv_header_ncurses_curses_h=yes],
                    [ax_cv_header_ncurses_curses_h=no])
            ])
            AS_IF([test "x$ax_cv_header_ncurses_curses_h" = xyes], [
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_COLOR],     [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE],  [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSES_CURSES_H], [1], [Define to 1 if <ncurses/curses.h> is present])
            ])

            AC_CACHE_CHECK([for working ncurses.h], [ax_cv_header_ncurses_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@include <ncurses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        chtype c = COLOR_PAIR(1) & A_COLOR;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                        init_pair(1, COLOR_WHITE, COLOR_RED);
                    ]])],
                    [ax_cv_header_ncurses_h=yes],
                    [ax_cv_header_ncurses_h=no])
            ])
            AS_IF([test "x$ax_cv_header_ncurses_h" = xyes], [
                ax_cv_curses_color=yes
                ax_cv_curses_obsolete=yes
                AC_DEFINE([HAVE_CURSES_COLOR],    [1], [Define to 1 if library supports color (enhanced functions)])
                AC_DEFINE([HAVE_CURSES_OBSOLETE], [1], [Define to 1 if library supports certain obsolete features])
                AC_DEFINE([HAVE_NCURSES_H],       [1], [Define to 1 if <ncurses.h> is present])
            ])

            AS_IF([test "x$ax_cv_header_ncurses_curses_h" = xno && test "x$ax_cv_header_ncurses_h" = xno], [
                AC_MSG_WARN([could not find a working ncurses/curses.h or ncurses.h])
            ])
        ])
    ])
    unset pkg_cv__ax_cv_ncurses_libs
    unset pkg_cv__ax_cv_ncurses_cppflags

    # Test for plain Curses (or if CURSES_LIBS was set by user)
    AS_IF([test "x$with_plaincurses" != xno && test "x$ax_cv_curses_which" = xno], [
        AS_IF([test "x$CURSES_LIBS" != x], [
            LIBS="$ax_saved_LIBS $CURSES_LIBS"
        ], [
            LIBS="$ax_saved_LIBS -lcurses"
        ])

        AC_CACHE_CHECK([for Curses library], [ax_cv_plaincurses], [
            AC_LINK_IFELSE([AC_LANG_CALL([], [initscr])],
                [ax_cv_plaincurses=yes], [ax_cv_plaincurses=no])
        ])

        AS_IF([test "x$ax_cv_plaincurses" = xyes], [
            ax_cv_curses=yes
            ax_cv_curses_which=plaincurses
            AS_IF([test "x$CURSES_LIBS" = x], [
                CURSES_LIBS="-lcurses"
            ])
            AC_DEFINE([HAVE_CURSES], [1], [Define to 1 if a SysV or X/Open compatible Curses library is present])

            # Check for base conformance (and header file)

            AC_CACHE_CHECK([for working curses.h], [ax_cv_header_curses_h], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@include <curses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        initscr();
                    ]])],
                    [ax_cv_header_curses_h=yes],
                    [ax_cv_header_curses_h=no])
            ])
            AS_IF([test "x$ax_cv_header_curses_h" = xyes], [
                AC_DEFINE([HAVE_CURSES_H], [1], [Define to 1 if <curses.h> is present])

                # Check for X/Open Enhanced conformance

                AC_CACHE_CHECK([for X/Open Enhanced Curses conformance], [ax_cv_plaincurses_enhanced], [
                    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                            @%:@define _XOPEN_SOURCE_EXTENDED 1
                            @%:@include <curses.h>
                            @%:@ifndef _XOPEN_CURSES
                            @%:@error "this Curses library is not enhanced"
                            "this Curses library is not enhanced"
                            @%:@endif
                        ]], [[
                            chtype a = A_BOLD;
                            int b = KEY_LEFT;
                            chtype c = COLOR_PAIR(1) & A_COLOR;
                            attr_t d = WA_NORMAL;
                            cchar_t e;
                            wint_t f;
                            initscr();
                            init_pair(1, COLOR_WHITE, COLOR_RED);
                            wattr_set(stdscr, d, 0, NULL);
                            wget_wch(stdscr, &f);
                        ]])],
                        [ax_cv_plaincurses_enhanced=yes],
                        [ax_cv_plaincurses_enhanced=no])
                ])
                AS_IF([test "x$ax_cv_plaincurses_enhanced" = xyes], [
                    ax_cv_curses_enhanced=yes
                    ax_cv_curses_color=yes
                    AC_DEFINE([HAVE_CURSES_ENHANCED], [1], [Define to 1 if library supports X/Open Enhanced functions])
                    AC_DEFINE([HAVE_CURSES_COLOR],    [1], [Define to 1 if library supports color (enhanced functions)])
                ])

                # Check for color functions

                AC_CACHE_CHECK([for Curses color functions], [ax_cv_plaincurses_color], [
                    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@define _XOPEN_SOURCE_EXTENDED 1
                        @%:@include <curses.h>
                        ]], [[
                            chtype a = A_BOLD;
                            int b = KEY_LEFT;
                            chtype c = COLOR_PAIR(1) & A_COLOR;
                            initscr();
                            init_pair(1, COLOR_WHITE, COLOR_RED);
                        ]])],
                        [ax_cv_plaincurses_color=yes],
                        [ax_cv_plaincurses_color=no])
                ])
                AS_IF([test "x$ax_cv_plaincurses_color" = xyes], [
                    ax_cv_curses_color=yes
                    AC_DEFINE([HAVE_CURSES_COLOR], [1], [Define to 1 if library supports color (enhanced functions)])
                ])

                # Check for obsolete functions

                AC_CACHE_CHECK([for obsolete Curses functions], [ax_cv_plaincurses_obsolete], [
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[
                        @%:@include <curses.h>
                    ]], [[
                        chtype a = A_BOLD;
                        int b = KEY_LEFT;
                        int g = getattrs(stdscr);
                        int h = getcurx(stdscr) + getmaxx(stdscr);
                        initscr();
                    ]])],
                    [ax_cv_plaincurses_obsolete=yes],
                    [ax_cv_plaincurses_obsolete=no])
                ])
                AS_IF([test "x$ax_cv_plaincurses_obsolete" = xyes], [
                    ax_cv_curses_obsolete=yes
                    AC_DEFINE([HAVE_CURSES_OBSOLETE], [1], [Define to 1 if library supports certain obsolete features])
                ])
            ])

            AS_IF([test "x$ax_cv_header_curses_h" = xno], [
                AC_MSG_WARN([could not find a working curses.h])
            ])
        ])
    ])

    AS_IF([test "x$ax_cv_curses"          != xyes], [ax_cv_curses=no])
    AS_IF([test "x$ax_cv_curses_enhanced" != xyes], [ax_cv_curses_enhanced=no])
    AS_IF([test "x$ax_cv_curses_color"    != xyes], [ax_cv_curses_color=no])
    AS_IF([test "x$ax_cv_curses_obsolete" != xyes], [ax_cv_curses_obsolete=no])

    LIBS=$ax_saved_LIBS
    CPPFLAGS=$ax_saved_CPPFLAGS

    unset ax_saved_LIBS
    unset ax_saved_CPPFLAGS
])dnl

# pkg.m4 - Macros to locate and use pkg-config.   -*- Autoconf -*-
# serial 13 (pkgconf)

dnl Copyright © 2004 Scott James Remnant <scott@netsplit.com>.
dnl Copyright © 2012-2015 Dan Nicholson <dbn.lists@gmail.com>
dnl
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 2 of the License, or
dnl (at your option) any later version.
dnl
dnl This program is distributed in the hope that it will be useful, but
dnl WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
dnl General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, see <https://www.gnu.org/licenses/>.
dnl
dnl As a special exception to the GNU General Public License, if you
dnl distribute this file as part of a program that contains a
dnl configuration script generated by Autoconf, you may include it under
dnl the same distribution terms that you use for the rest of that
dnl program.

dnl PKG_PREREQ(MIN-VERSION)
dnl -----------------------
dnl Since: 0.29
dnl
dnl Verify that the version of the pkg-config macros are at least
dnl MIN-VERSION. Unlike PKG_PROG_PKG_CONFIG, which checks the user's
dnl installed version of pkg-config, this checks the developer's version
dnl of pkg.m4 when generating configure.
dnl
dnl To ensure that this macro is defined, also add:
dnl m4_ifndef([PKG_PREREQ],
dnl     [m4_fatal([must install pkg-config 0.29 or later before running autoconf/autogen])])
dnl
dnl See the "Since" comment for each macro you use to see what version
dnl of the macros you require.
m4_defun([PKG_PREREQ],
[m4_define([PKG_MACROS_VERSION], [0.29.2])
m4_if(m4_version_compare(PKG_MACROS_VERSION, [$1]), -1,
    [m4_fatal([pkg.m4 version $1 or higher is required but ]PKG_MACROS_VERSION[ found])])
])dnl PKG_PREREQ

dnl PKG_PROG_PKG_CONFIG([MIN-VERSION], [ACTION-IF-NOT-FOUND])
dnl ---------------------------------------------------------
dnl Since: 0.16
dnl
dnl Search for the pkg-config tool and set the PKG_CONFIG variable to
dnl first found in the path. Checks that the version of pkg-config found
dnl is at least MIN-VERSION. If MIN-VERSION is not specified, 0.9.0 is
dnl used since that's the first version where most current features of
dnl pkg-config existed.
dnl
dnl If pkg-config is not found or older than specified, it will result
dnl in an empty PKG_CONFIG variable. To avoid widespread issues with
dnl scripts not checking it, ACTION-IF-NOT-FOUND defaults to aborting.
dnl You can specify [PKG_CONFIG=false] as an action instead, which would
dnl result in pkg-config tests failing, but no bogus error messages.
AC_DEFUN([PKG_PROG_PKG_CONFIG],
[m4_pattern_forbid([^_?PKG_[A-Z_]+$])
m4_pattern_allow([^PKG_CONFIG(_(PATH|LIBDIR|SYSROOT_DIR|ALLOW_SYSTEM_(CFLAGS|LIBS)))?$])
m4_pattern_allow([^PKG_CONFIG_(DISABLE_UNINSTALLED|TOP_BUILD_DIR|DEBUG_SPEW)$])
AC_ARG_VAR([PKG_CONFIG], [path to pkg-config utility])
AC_ARG_VAR([PKG_CONFIG_PATH], [directories to add to pkg-config's search path])
AC_ARG_VAR([PKG_CONFIG_LIBDIR], [path overriding pkg-config's built-in search path])

if test "x$ac_cv_env_PKG_CONFIG_set" != "xset"; then
	AC_PATH_TOOL([PKG_CONFIG], [pkg-config])
fi
if test -n "$PKG_CONFIG"; then
	_pkg_min_version=m4_default([$1], [0.9.0])
	AC_MSG_CHECKING([pkg-config is at least version $_pkg_min_version])
	if $PKG_CONFIG --atleast-pkgconfig-version $_pkg_min_version; then
		AC_MSG_RESULT([yes])
	else
		AC_MSG_RESULT([no])
		PKG_CONFIG=""
	fi
fi
if test -z "$PKG_CONFIG"; then
	m4_default([$2], [AC_MSG_ERROR([pkg-config not found])])
fi[]dnl
])dnl PKG_PROG_PKG_CONFIG

dnl PKG_CHECK_EXISTS(MODULES, [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
dnl -------------------------------------------------------------------
dnl Since: 0.18
dnl
dnl Check to see whether a particular set of modules exists. Similar to
dnl PKG_CHECK_MODULES(), but does not set variables or print errors.
dnl
dnl Please remember that m4 expands AC_REQUIRE([PKG_PROG_PKG_CONFIG])
dnl only at the first occurrence in configure.ac, so if the first place
dnl it's called might be skipped (such as if it is within an "if", you
dnl have to call PKG_CHECK_EXISTS manually
AC_DEFUN([PKG_CHECK_EXISTS],
[AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
if test -n "$PKG_CONFIG" && \
    AC_RUN_LOG([$PKG_CONFIG --exists --print-errors "$1"]); then
  m4_default([$2], [:])
m4_ifvaln([$3], [else
  $3])dnl
fi])

dnl _PKG_CONFIG([VARIABLE], [COMMAND], [MODULES])
dnl ---------------------------------------------
dnl Internal wrapper calling pkg-config via PKG_CONFIG and setting
dnl pkg_failed based on the result.
m4_define([_PKG_CONFIG],
[if test -n "$$1"; then
    pkg_cv_[]$1="$$1"
 elif test -n "$PKG_CONFIG"; then
    PKG_CHECK_EXISTS([$3],
                     [pkg_cv_[]$1=`$PKG_CONFIG --[]$2 "$3" 2>/dev/null`
		      test "x$?" != "x0" && pkg_failed=yes ],
		     [pkg_failed=yes])
 else
    pkg_failed=untried
fi[]dnl
])dnl _PKG_CONFIG

dnl _PKG_SHORT_ERRORS_SUPPORTED
dnl ---------------------------
dnl Internal check to see if pkg-config supports short errors.
AC_DEFUN([_PKG_SHORT_ERRORS_SUPPORTED],
[AC_REQUIRE([PKG_PROG_PKG_CONFIG])
if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
        _pkg_short_errors_supported=yes
else
        _pkg_short_errors_supported=no
fi[]dnl
])dnl _PKG_SHORT_ERRORS_SUPPORTED


dnl PKG_CHECK_MODULES(VARIABLE-PREFIX, MODULES, [ACTION-IF-FOUND],
dnl   [ACTION-IF-NOT-FOUND])
dnl --------------------------------------------------------------
dnl Since: 0.4.0
dnl
dnl Note that if there is a possibility the first call to
dnl PKG_CHECK_MODULES might not happen, you should be sure to include an
dnl explicit call to PKG_PROG_PKG_CONFIG in your configure.ac
AC_DEFUN([PKG_CHECK_MODULES],
[AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
AC_ARG_VAR([$1][_CFLAGS], [C compiler flags for $1, overriding pkg-config])dnl
AC_ARG_VAR([$1][_LIBS], [linker flags for $1, overriding pkg-config])dnl

pkg_failed=no
AC_MSG_CHECKING([for $2])

_PKG_CONFIG([$1][_CFLAGS], [cflags], [$2])
_PKG_CONFIG([$1][_LIBS], [libs], [$2])

m4_define([_PKG_TEXT], [Alternatively, you may set the environment variables $1[]_CFLAGS
and $1[]_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.])

if test $pkg_failed = yes; then
        AC_MSG_RESULT([no])
        _PKG_SHORT_ERRORS_SUPPORTED
        if test $_pkg_short_errors_supported = yes; then
                $1[]_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "$2" 2>&1`
        else
                $1[]_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "$2" 2>&1`
        fi
        # Put the nasty error message in config.log where it belongs
        echo "$$1[]_PKG_ERRORS" >&AS_MESSAGE_LOG_FD

        m4_default([$4], [AC_MSG_ERROR(
[Package requirements ($2) were not met:

$$1_PKG_ERRORS

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.

_PKG_TEXT])[]dnl
        ])
elif test $pkg_failed = untried; then
        AC_MSG_RESULT([no])
        m4_default([$4], [AC_MSG_FAILURE(
[The pkg-config script could not be found or is too old.  Make sure it
is in your PATH or set the PKG_CONFIG environment variable to the full
path to pkg-config.

_PKG_TEXT

To get pkg-config, see <http://pkg-config.freedesktop.org/>.])[]dnl
        ])
else
        $1[]_CFLAGS=$pkg_cv_[]$1[]_CFLAGS
        $1[]_LIBS=$pkg_cv_[]$1[]_LIBS
        AC_MSG_RESULT([yes])
        $3
fi[]dnl
])dnl PKG_CHECK_MODULES


dnl PKG_CHECK_MODULES_STATIC(VARIABLE-PREFIX, MODULES, [ACTION-IF-FOUND],
dnl   [ACTION-IF-NOT-FOUND])
dnl ---------------------------------------------------------------------
dnl Since: 0.29
dnl
dnl Checks for existence of MODULES and gathers its build flags with
dnl static libraries enabled. Sets VARIABLE-PREFIX_CFLAGS from --cflags
dnl and VARIABLE-PREFIX_LIBS from --libs.
dnl
dnl Note that if there is a possibility the first call to
dnl PKG_CHECK_MODULES_STATIC might not happen, you should be sure to
dnl include an explicit call to PKG_PROG_PKG_CONFIG in your
dnl configure.ac.
AC_DEFUN([PKG_CHECK_MODULES_STATIC],
[AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
_save_PKG_CONFIG=$PKG_CONFIG
PKG_CONFIG="$PKG_CONFIG --static"
PKG_CHECK_MODULES($@)
PKG_CONFIG=$_save_PKG_CONFIG[]dnl
])dnl PKG_CHECK_MODULES_STATIC


dnl PKG_INSTALLDIR([DIRECTORY])
dnl -------------------------
dnl Since: 0.27
dnl
dnl Substitutes the variable pkgconfigdir as the location where a module
dnl should install pkg-config .pc files. By default the directory is
dnl $libdir/pkgconfig, but the default can be changed by passing
dnl DIRECTORY. The user can override through the --with-pkgconfigdir
dnl parameter.
AC_DEFUN([PKG_INSTALLDIR],
[m4_pushdef([pkg_default], [m4_default([$1], ['${libdir}/pkgconfig'])])
m4_pushdef([pkg_description],
    [pkg-config installation directory @<:@]pkg_default[@:>@])
AC_ARG_WITH([pkgconfigdir],
    [AS_HELP_STRING([--with-pkgconfigdir], pkg_description)],,
    [with_pkgconfigdir=]pkg_default)
AC_SUBST([pkgconfigdir], [$with_pkgconfigdir])
m4_popdef([pkg_default])
m4_popdef([pkg_description])
])dnl PKG_INSTALLDIR


dnl PKG_NOARCH_INSTALLDIR([DIRECTORY])
dnl --------------------------------
dnl Since: 0.27
dnl
dnl Substitutes the variable noarch_pkgconfigdir as the location where a
dnl module should install arch-independent pkg-config .pc files. By
dnl default the directory is $datadir/pkgconfig, but the default can be
dnl changed by passing DIRECTORY. The user can override through the
dnl --with-noarch-pkgconfigdir parameter.
AC_DEFUN([PKG_NOARCH_INSTALLDIR],
[m4_pushdef([pkg_default], [m4_default([$1], ['${datadir}/pkgconfig'])])
m4_pushdef([pkg_description],
    [pkg-config arch-independent installation directory @<:@]pkg_default[@:>@])
AC_ARG_WITH([noarch-pkgconfigdir],
    [AS_HELP_STRING([--with-noarch-pkgconfigdir], pkg_description)],,
    [with_noarch_pkgconfigdir=]pkg_default)
AC_SUBST([noarch_pkgconfigdir], [$with_noarch_pkgconfigdir])
m4_popdef([pkg_default])
m4_popdef([pkg_description])
])dnl PKG_NOARCH_INSTALLDIR


dnl PKG_CHECK_VAR(VARIABLE, MODULE, CONFIG-VARIABLE,
dnl [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
dnl -------------------------------------------
dnl Since: 0.28
dnl
dnl Retrieves the value of the pkg-config variable for the given module.
AC_DEFUN([PKG_CHECK_VAR],
[AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
AC_ARG_VAR([$1], [value of $3 for $2, overriding pkg-config])dnl

_PKG_CONFIG([$1], [variable="][$3]["], [$2])
AS_VAR_COPY([$1], [pkg_cv_][$1])

AS_VAR_IF([$1], [""], [$5], [$4])dnl
])dnl PKG_CHECK_VAR

dnl PKG_WITH_MODULES(VARIABLE-PREFIX, MODULES,
dnl   [ACTION-IF-FOUND],[ACTION-IF-NOT-FOUND],
dnl   [DESCRIPTION], [DEFAULT])
dnl ------------------------------------------
dnl
dnl Prepare a "--with-" configure option using the lowercase
dnl [VARIABLE-PREFIX] name, merging the behaviour of AC_ARG_WITH and
dnl PKG_CHECK_MODULES in a single macro.
AC_DEFUN([PKG_WITH_MODULES],
[
m4_pushdef([with_arg], m4_tolower([$1]))

m4_pushdef([description],
           [m4_default([$5], [build with ]with_arg[ support])])

m4_pushdef([def_arg], [m4_default([$6], [auto])])
m4_pushdef([def_action_if_found], [AS_TR_SH([with_]with_arg)=yes])
m4_pushdef([def_action_if_not_found], [AS_TR_SH([with_]with_arg)=no])

m4_case(def_arg,
            [yes],[m4_pushdef([with_without], [--without-]with_arg)],
            [m4_pushdef([with_without],[--with-]with_arg)])

AC_ARG_WITH(with_arg,
     AS_HELP_STRING(with_without, description[ @<:@default=]def_arg[@:>@]),,
    [AS_TR_SH([with_]with_arg)=def_arg])

AS_CASE([$AS_TR_SH([with_]with_arg)],
            [yes],[PKG_CHECK_MODULES([$1],[$2],$3,$4)],
            [auto],[PKG_CHECK_MODULES([$1],[$2],
                                        [m4_n([def_action_if_found]) $3],
                                        [m4_n([def_action_if_not_found]) $4])])

m4_popdef([with_arg])
m4_popdef([description])
m4_popdef([def_arg])

])dnl PKG_WITH_MODULES

dnl PKG_HAVE_WITH_MODULES(VARIABLE-PREFIX, MODULES,
dnl   [DESCRIPTION], [DEFAULT])
dnl -----------------------------------------------
dnl
dnl Convenience macro to trigger AM_CONDITIONAL after PKG_WITH_MODULES
dnl check._[VARIABLE-PREFIX] is exported as make variable.
AC_DEFUN([PKG_HAVE_WITH_MODULES],
[
PKG_WITH_MODULES([$1],[$2],,,[$3],[$4])

AM_CONDITIONAL([HAVE_][$1],
               [test "$AS_TR_SH([with_]m4_tolower([$1]))" = "yes"])
])dnl PKG_HAVE_WITH_MODULES

dnl PKG_HAVE_DEFINE_WITH_MODULES(VARIABLE-PREFIX, MODULES,
dnl   [DESCRIPTION], [DEFAULT])
dnl ------------------------------------------------------
dnl
dnl Convenience macro to run AM_CONDITIONAL and AC_DEFINE after
dnl PKG_WITH_MODULES check. HAVE_[VARIABLE-PREFIX] is exported as make
dnl and preprocessor variable.
AC_DEFUN([PKG_HAVE_DEFINE_WITH_MODULES],
[
PKG_HAVE_WITH_MODULES([$1],[$2],[$3],[$4])

AS_IF([test "$AS_TR_SH([with_]m4_tolower([$1]))" = "yes"],
        [AC_DEFINE([HAVE_][$1], 1, [Enable ]m4_tolower([$1])[ support])])
])dnl PKG_HAVE_DEFINE_WITH_MODULES

# Configure paths for SDL
# Sam Lantinga 9/21/99
# stolen from Manish Singh
# stolen back from Frank Belew
# stolen from Manish Singh
# Shamelessly stolen from Owen Taylor
#
# Changelog:
# * also look for SDL2.framework under Mac OS X
# * removed HP/UX 9 support.
# * updated for newer autoconf.
# * (v3) use $PKG_CONFIG for pkg-config cross-compiling support

# serial 3

dnl AM_PATH_SDL2([MINIMUM-VERSION, [ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]]])
dnl Test for SDL, and define SDL_CFLAGS and SDL_LIBS
dnl
AC_DEFUN([AM_PATH_SDL2],
[dnl
dnl Get the cflags and libraries from the sdl2-config script
dnl
AC_ARG_WITH(sdl-prefix,[  --with-sdl-prefix=PFX   Prefix where SDL is installed (optional)],
            sdl_prefix="$withval", sdl_prefix="")
AC_ARG_WITH(sdl-exec-prefix,[  --with-sdl-exec-prefix=PFX Exec prefix where SDL is installed (optional)],
            sdl_exec_prefix="$withval", sdl_exec_prefix="")
AC_ARG_ENABLE(sdltest, [  --disable-sdltest       Do not try to compile and run a test SDL program],
		    , enable_sdltest=yes)
AC_ARG_ENABLE(sdlframework, [  --disable-sdlframework Do not search for SDL2.framework],
        , search_sdl_framework=yes)

AC_ARG_VAR(SDL2_FRAMEWORK, [Path to SDL2.framework])

  min_sdl_version=ifelse([$1], ,2.0.0,$1)

  if test "x$sdl_prefix$sdl_exec_prefix" = x ; then
    PKG_CHECK_MODULES([SDL], [sdl2 >= $min_sdl_version],
           [sdl_pc=yes],
           [sdl_pc=no])
  else
    sdl_pc=no
    if test x$sdl_exec_prefix != x ; then
      sdl_config_args="$sdl_config_args --exec-prefix=$sdl_exec_prefix"
      if test x${SDL2_CONFIG+set} != xset ; then
        SDL2_CONFIG=$sdl_exec_prefix/bin/sdl2-config
      fi
    fi
    if test x$sdl_prefix != x ; then
      sdl_config_args="$sdl_config_args --prefix=$sdl_prefix"
      if test x${SDL2_CONFIG+set} != xset ; then
        SDL2_CONFIG=$sdl_prefix/bin/sdl2-config
      fi
    fi
  fi

  if test "x$sdl_pc" = xyes ; then
    no_sdl=""
    SDL2_CONFIG="$PKG_CONFIG sdl2"
  else
    as_save_PATH="$PATH"
    if test "x$prefix" != xNONE && test "$cross_compiling" != yes; then
      PATH="$prefix/bin:$prefix/usr/bin:$PATH"
    fi
    AC_PATH_PROG(SDL2_CONFIG, sdl2-config, no, [$PATH])
    PATH="$as_save_PATH"
    no_sdl=""

    if test "$SDL2_CONFIG" = "no" -a "x$search_sdl_framework" = "xyes"; then
      AC_MSG_CHECKING(for SDL2.framework)
      if test "x$SDL2_FRAMEWORK" != x; then
        sdl_framework=$SDL2_FRAMEWORK
      else
        for d in / ~/ /System/; do
          if test -d "${d}Library/Frameworks/SDL2.framework"; then
            sdl_framework="${d}Library/Frameworks/SDL2.framework"
          fi
        done
      fi

      if test x"$sdl_framework" != x && test -d "$sdl_framework"; then
        AC_MSG_RESULT($sdl_framework)
        sdl_framework_dir=`dirname $sdl_framework`
        SDL_CFLAGS="-F$sdl_framework_dir -Wl,-framework,SDL2 -I$sdl_framework/include"
        SDL_LIBS="-F$sdl_framework_dir -Wl,-framework,SDL2"
      else
        no_sdl=yes
      fi
    fi

    if test "$SDL2_CONFIG" != "no"; then
      if test "x$sdl_pc" = "xno"; then
        AC_MSG_CHECKING(for SDL - version >= $min_sdl_version)
        SDL_CFLAGS=`$SDL2_CONFIG $sdl_config_args --cflags`
        SDL_LIBS=`$SDL2_CONFIG $sdl_config_args --libs`
      fi

      sdl_major_version=`$SDL2_CONFIG $sdl_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\1/'`
      sdl_minor_version=`$SDL2_CONFIG $sdl_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\2/'`
      sdl_micro_version=`$SDL2_CONFIG $sdl_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\3/'`
      if test "x$enable_sdltest" = "xyes" ; then
        ac_save_CFLAGS="$CFLAGS"
        ac_save_CXXFLAGS="$CXXFLAGS"
        ac_save_LIBS="$LIBS"
        CFLAGS="$CFLAGS $SDL_CFLAGS"
        CXXFLAGS="$CXXFLAGS $SDL_CFLAGS"
        LIBS="$LIBS $SDL_LIBS"
dnl
dnl Now check if the installed SDL is sufficiently new. (Also sanity
dnl checks the results of sdl2-config to some extent
dnl
      rm -f conf.sdltest
      AC_RUN_IFELSE([AC_LANG_SOURCE([[
#include <stdio.h>
#include <stdlib.h>
#include "SDL.h"

int main (int argc, char *argv[])
{
  int major, minor, micro;
  FILE *fp = fopen("conf.sdltest", "w");

  if (fp) fclose(fp);

  if (sscanf("$min_sdl_version", "%d.%d.%d", &major, &minor, &micro) != 3) {
     printf("%s, bad version string\n", "$min_sdl_version");
     exit(1);
   }

   if (($sdl_major_version > major) ||
      (($sdl_major_version == major) && ($sdl_minor_version > minor)) ||
      (($sdl_major_version == major) && ($sdl_minor_version == minor) && ($sdl_micro_version >= micro)))
    {
      return 0;
    }
  else
    {
      printf("\n*** 'sdl2-config --version' returned %d.%d.%d, but the minimum version\n", $sdl_major_version, $sdl_minor_version, $sdl_micro_version);
      printf("*** of SDL required is %d.%d.%d. If sdl2-config is correct, then it is\n", major, minor, micro);
      printf("*** best to upgrade to the required version.\n");
      printf("*** If sdl2-config was wrong, set the environment variable SDL2_CONFIG\n");
      printf("*** to point to the correct copy of sdl2-config, and remove the file\n");
      printf("*** config.cache before re-running configure\n");
      return 1;
    }
}

]])], [], [no_sdl=yes], [echo $ac_n "cross compiling; assumed OK... $ac_c"])
        CFLAGS="$ac_save_CFLAGS"
        CXXFLAGS="$ac_save_CXXFLAGS"
        LIBS="$ac_save_LIBS"

      fi
      if test "x$sdl_pc" = "xno"; then
        if test "x$no_sdl" = "xyes"; then
          AC_MSG_RESULT(no)
        else
          AC_MSG_RESULT(yes)
        fi
      fi
    fi
  fi
  if test "x$no_sdl" = x ; then
     ifelse([$2], , :, [$2])
  else
     if test "$SDL2_CONFIG" = "no" ; then
       echo "*** The sdl2-config script installed by SDL could not be found"
       echo "*** If SDL was installed in PREFIX, make sure PREFIX/bin is in"
       echo "*** your path, or set the SDL2_CONFIG environment variable to the"
       echo "*** full path to sdl2-config."
     else
       if test -f conf.sdltest ; then
        :
       else
          echo "*** Could not run SDL test program, checking why..."
          CFLAGS="$CFLAGS $SDL_CFLAGS"
          CXXFLAGS="$CXXFLAGS $SDL_CFLAGS"
          LIBS="$LIBS $SDL_LIBS"
          AC_LINK_IFELSE([AC_LANG_PROGRAM([[
#include <stdio.h>
#include "SDL.h"

int main(int argc, char *argv[])
{ return 0; }
#undef  main
#define main K_and_R_C_main
]], [[ return 0; ]])],
        [ echo "*** The test program compiled, but did not run. This usually means"
          echo "*** that the run-time linker is not finding SDL or finding the wrong"
          echo "*** version of SDL. If it is not finding SDL, you'll need to set your"
          echo "*** LD_LIBRARY_PATH environment variable, or edit /etc/ld.so.conf to point"
          echo "*** to the installed location  Also, make sure you have run ldconfig if that"
          echo "*** is required on your system"
	  echo "***"
          echo "*** If you have an old version installed, it is best to remove it, although"
          echo "*** you may also be able to get things to work by modifying LD_LIBRARY_PATH"],
        [ echo "*** The test program failed to compile or link. See the file config.log for the"
          echo "*** exact error that occurred. This usually means SDL was incorrectly installed"
          echo "*** or that you have moved SDL since it was installed. In the latter case, you"
          echo "*** may want to edit the sdl2-config script: $SDL2_CONFIG" ])
          CFLAGS="$ac_save_CFLAGS"
          CXXFLAGS="$ac_save_CXXFLAGS"
          LIBS="$ac_save_LIBS"
       fi
     fi
     SDL_CFLAGS=""
     SDL_LIBS=""
     ifelse([$3], , :, [$3])
  fi
  AC_SUBST(SDL_CFLAGS)
  AC_SUBST(SDL_LIBS)
  rm -f conf.sdltest
])

