%%%
Title = "Textual presentation of DNS Data"
abbrev = "Textual presentation of DNS Data"
docname = "@DOCNAME@"
category = "std"

ipr = "trust200902"
area = "Internet"
workgroup = "DNSOP Working Group"
date = @TODAY@

[seriesInfo]
name = "Internet-Draft"
value = "@DOCNAME@"
stream = "IETF"
status = "standard"

[[author]]
initials="J.T.M."
surname="Koekkoek"
fullname="Jeroen Koekkoek"
organization = "NLnet Labs"
  [author.address]
  email = "jeroen@nlnetlabs.nl"

%%%

.# Abstract

The textual presentation formats originally specified in [@!RFC1034] and
[@!RFC1035], provide a portable representation of RRs in text form. They
define a tabular serialization format with provisions for convenient editing.

The existing specification is ambiguous, leading to incompatibilites between
implementations that intend to be compliant. This document redefines the
presentation format to remove any such ambiguities and establish a minimal,
well-defined, set accepted by all implementations

{mainmatter}

Master files provide a lean portable serialization format. Master files are
mostly generated these days, but the format clearly reflects the fact that
convenient editing by hand was a design goal.


# Introduction

TODO


# Terminology

[@!RFC1035] section 5.1 specifies a format for files containing RRs in text
form named master files. The format, with additional considerations, is most
frequently used to define a zone, but can be used in other scenarios where RRs
are stored in text form. [@!RFC1034] section 3.6.1 specifies the textual
expression of RRs. The text in [@!RFC1034] states a style similar to that in
[@!RFC1035] is adopted to present the contents of RRs. As such, [@!RFC1034]
and [@!RFC1035] define three adjacent formats.

1. Textual expression of RRs ([@!RFC1034] section 3.6.1).
2. Master files ([@!RFC1035] section 5.1).
3. Restrictions to master files when defining a zone ([@!RFC1035] section 5.2).


## Textual expression of RRs

The distinction between Textual expression of RRs and master files is not
clearly defined. [@!RFC1034] merely states RRs are presented in a style
similar to that used in master files to show the contents of RRs.
Specifically, it states most RRs are shown on a single line, but that line
continuations are possible using parenthesis and that blank lines may be used
for readability. [@!RFC1035] formally defines both types of entries, plus a
set of control entries. While there is no mention of comment in [@!RFC1034]
section 3.6.1, it stands to reason all of the syntax and semantics for blank
and rr entries, as defined in [@!RFC0135] section 5.1, is adopted. More so,
because comments are used in the zone data example in [@!RFC1034] section 6.1.
Therefore, the format defined in [@!RFC1034] section 3.6.1, for all intents
and purposes, is a subset of the format used in master files as defined by
[@!RFC1035] section 5.1.


## Master files

Master files are text files that contain RRs in text form. Since the contents
of a zone can be expressed in the form of a list of RRs a master file is most
often used to define a zone, though it can be used to list a cache's contents.
(Quoted from [RFC1035], Section 5)

The master file format defines syntax and semantics for various types of
entries. Like [@!RFC1034], it prescribes how to express the contents of RRs,
but additionally introduces control entries for more convenient editing.
e.g. allow for templating and deduplication through use of $INCLUDE.


## Zone files

Zone files provide a standardized means to define zones in authoritative name
servers and are supported by most open source implementations. The additional
restictions that apply when defining a zone are clear and consice, no
additional syntax rules are introduced.


## Presentation format

In practice, there is no distinction between the formats defined in
[@!RFC1034] section 3.6.1 and [@!RFC1035] section 5.1 and the term
"presentation format" is often used instead. [@!RFC8499] section 5 formally
consolidates both definitions by stating it is the text format used in master
files as shown, not formally defined, in [@!RFC1034] or [@!RFC1035].

The term presentation format is strongly preferred over the term master files
because the latter may wrongfully signal it as being a format used solely for the
purpose of defining zones within a primary authoritative name server.

FIXME: This document must use the presentation format from here on!


# Format

The format of master files is a sequence of entries. Entries are predominantly
line-oriented, though parentheses can be used to continue a list of items
across a line boundary, and text literals can contain CRLF within the text.
Any combination of tabs and spaces act as a delimiter between the separate
items that make up an entry.  The end of any line in the master file can end
with a comment.  The comment starts with a ";" (semicolon).

The following entries are defined:

    <blank>[<comment>]

    $ORIGIN <domain-name> [<comment>]

    $INCLUDE <file-name> [<domain-name>] [<comment>]

    <domain-name><rr> [<comment>]

    <blank><rr> [<comment>]

[@!RFC2308] extends the format to include the $TTL directive.

[@!RFC3597] extends the format to allow for generic notation of classes, types, and RDATA.

FIXME: Probably include more from RFC1035, possibly with better wording.

FIXME: Define a proper EBNF grammar for the minimal syntax (if possible).

FIXME: Define RDATA must adhere to character strings. Meaning either
       \<contiguous\> set of characters without delimiters or \<quoted\> text.
       State that this does not mean all fields in RDATA may be quoted. State
       that this is important for performance reasons (SIMD), but also
       alleviates parsers from having to implement additional lexers for
       RDATA when new RDATA fields are introduced. Another good point made by
       @shane-kerr is that restricting the syntax allows parsers that do not
       understand the syntax to skip records it cannot interpret.

       The exception here being SVCB, which is mostly already accepted. We do
       want to limit future RFCs though. SVCB could have chosen a slightly
       different presentation. e.g. drop the equals sign.


FIXME: Go into expansion rules for `@`.

FIXME: Evaluate for inclusion: https://datatracker.ietf.org/doc/html/rfc2181#section-8

FIXME: Evaluate for inclusion: https://www.rfc-editor.org/rfc/rfc8767#section-4
       @shane-kerr: "Any software reading a zone file that encounters a TTL
                     more than 2^31 - 1 SHOULD reduce the TTL to 2^31 -1 or
                     consider the RR an error."

FIXME: Evaluate for inclusion: https://github.com/NLnetLabs/ldns/commit/cb101c9
       (from @shane-kerr) How do we handle the corner case where the first
       record does not have a TTL when the file does not define a zone.

FIXME: Consider formally promoting the use of key=value as introduced by SVCB

FIXME: Consider https://github.com/NLnetLabs/simdzone/blob/main/FORMAT.md

FIXME: (from @shane-kerr) Probably a section on how to handle errors should be
       included. Nothing too complex, but maybe prescribe a list of options?


## Intentional extensibility

[@!RFC1034] states the resource data or RDATA section of the RR
are given using knowledge of the typical representation for the data.
Similarly [@!RFC1035] states RDATA MUST be appropriate to the type and class.

Given the intentional extensibility of the DNS, new fields and the
corresponding syntax and semantics that apply to their presentation are
defined by later RFCs. Earlier RFCs can only define generic syntax rules like
the allowed use of parenthesis for line continuation, comments and the fact
that a line feed terminates an RR.

FIXME: Mention intentional extensibility further up. It is important to grasp.


## Control entries

TODO

FIXME: Lines starting with a dollar-sign must be considered a directive.


## $ORIGIN control entry

TODO

## $INCLUDE control entry

TODO

## $TTL control entry

TODO

{backmatter}
