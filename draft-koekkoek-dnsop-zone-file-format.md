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
presentation format to remove any such ambiguities.

{mainmatter}


# Introduction

[@!RFC1035] section 5.1 specifies a format for files containing RRs in text
form named master files. The format, with additional considerations, is most
frequently used to define a zone, but can be used in other scenarios where RRs
are stored in text form. [@!RFC1034] section 3.6.1 specifies the textual
expression of RRs. The text states a style similar to that in [@!RFC1035] is
adopted to present the contents of RRs. As such, [@!RFC1034] and [@!RFC1035]
define three adjacent formats.

1. Textual expression of RRs ([@!RFC1034] section 3.6.1).
2. Master files ([@!RFC1035] section 5.1).
3. Restrictions to master files when defining a zone ([@!RFC1035] section 5.2).

Textual expression of RRs is commonly referred to simply as presentation
format. The term first appeared in [@!RFC4034] and is officially defined in
[@!RFC8499]. [@!RFC8499], somewhat incorrectly, consolidates the textual
expression of RRs and master files. Each subsequent format complements the
former and is best considered a superset.


## Textual expression of RRs

The textual expession of RRs adopts a style similar to that used in master
files to show the contents of RRs. The text states most RRs are shown on a
single line, but states line continuations are possible using parenthesis.
The text does not mention either comments or directives, but does mention the
use of blank lines and comments are used in RFCs. Therefore, it stands to
reason syntax and semantics for blank and rr entries as defined for master
files is adopted.


## Master files

Master files are text files that contain RRs in text form. Since the contents
of a zone can be expressed in the form of a list of RRs a master file is most
often used to define a zone, though it can be used to list a cache's contents.
(Quoted from [RFC1035], Section 5)

Master files provide a lean portable serialization format. Master files are
mostly generated these days, but the format clearly reflects the fact that
convenient editing by hand was a design goal.

FIXME: Mention Root Files (https://www.iana.org/domains/root/files) are valid
       master files?

The master file format defines syntax and semantics for various types of
entries. Like [@!RFC1034], it states how to best show the contents of RRs,
but additionally introduces the concept of directives for more convenient
editing. e.g. allow for templating and deduplication through use of the
$INCLUDE directive.

FIXME: The term master files is inconvenient, perhaps we should come up with
       a new term?


## Intentional extensibility

[@!RFC1034] states the resource data or RDATA section of the RR
are given using knowledge of the typical representation for the data.
Similarly [@!RFC1035] states RDATA MUST be appropriate to the type and class.

Given the intentional extensibility of the DNS, new fields and the
corresponding syntax and semantics that apply to their presentation are
defined by later RFCs. Earlier RFCs can only define generic syntax rules like
the allowed use of parenthesis for line continuation, comments and the fact
that a line feed terminates an RR.


## Zone files

Zone files provide a standardized means to define zones in authoritative name
servers and are supported by most open source implementations. The additional
restictions that apply when defining a zone are clear and consice, no
additional syntax rules are introduced.

> All zone files are master files, but not all master files are zone files.


# Terminology

TODO


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

[@!RFC3597] externs the format to allow for generic notation of RDATA.

FIXME: Probably include more from RFC1035, possibly with better wording.

FIXME: Define a proper EBNF grammar for the minimal syntax (if possible).

FIXME: Define RDATA must adhere to character strings. Meaning either
       \<contiguous\> set of characters without delimiters or \<quoted\> text.
       State that this does not mean all fields in RDATA may be quoted. State
       that this is important for performance reasons (SIMD), but also
       alleviates parsers from having to implement additional lexers for
       RDATA when new RDATA fields are introduced.

       The exception here being SVCB, which is mostly already accepted. We do
       want to limit future RFCs though. SVCB could have chosen a slightly
       different presentation. e.g. drop the equals sign.


FIXME: Go into expansion rules for `@`.

FIXME: Lines starting with a dollar-sign must be considered a directive.

FIXME: Evaluate for inclusion: https://datatracker.ietf.org/doc/html/rfc2181#section-8
FIXME: Evaluate for inclusion: https://www.rfc-editor.org/rfc/rfc8767#section-4
FIXME: Evaluate for inclusion: https://github.com/NLnetLabs/ldns/commit/cb101c9

FIXME: Consider https://github.com/NLnetLabs/simdzone/blob/main/FORMAT.md

## Directives

TODO

## $ORIGIN directive

TODO

## $INCLUDE directive

TODO

## $TTL directive

TODO

TODO

{backmatter}
