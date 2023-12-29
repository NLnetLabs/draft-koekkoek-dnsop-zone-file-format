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

DNS resource records (RRs) can be expressed in text form using the DNS
presentation format. The presentation format is originally defined in
[@!RFC1035] section 5.1 and [@!RFC1034] section 3.6.1. The presentation format
is a concise tabular serialization format with provisions for convenient
editing.

The existing specification is ambiguous, leading to incompatibilites between
implementations that intend to be compliant. This document redefines the
presentation format to remove any such ambiguities and establish a minimal,
well-defined, set accepted by all implementations

{mainmatter}


# Introduction

The presentation format defined in [@!RFC1035] section 5.1 and [@!RFC1034]
section 3.6.1, defines syntax and semantics to present the contents of RRs in
text form. As a zone can be expressed in the form of a sequence of RRs, the
format is most frequently used to portably define zones, but the format has
many applications. The term "presentation format" is officially established in
[@!RFC8499] section 5.

The presentation format is a concise tabular serialization format with
provisions for convenient editing. While [@!RFC3597] section 4 defines generic
textual representations for type, class and RDATA, given the intentional
extensibility of the DNS, the presentation format can merely define a generic
text format for RRs, much like [@!RFC1035] section 4.1.3 defines a generic
wire format for RRs. The RDATA section of the RR must be given using knowledge
of the typical representation for the data and is out of scope though basic
syntax rules are defined to ensure support for future additions can be
implemented with minimal effort. The ABNF in [@!RFC9460] Appendix A
will be updated to correctly summarizes the allowed inputs.


# Terminology

[@!RFC1035] section 5.1 specifies a format for files containing RRs in text
form named master files. The format, with additional considerations, is most
frequently used to define a zone in master files, commonly referred to as zone
files.

[@!RFC1034] section 3.6.1 states RRs are presented in a style similar to that
used in master files to show the contents of RRs. Specifically, it states most
RRs are shown on a single line, but that line continuations are possible using
parenthesis and that blank lines may be used for readability. While there is
no mention of comments in [@!RFC1034] section 3.6.1, it stands to reason both
blank and rr entries defined in [@!RFC0135] section 5.1 are adopted. More so,
because comments are used in the zone data example in [@!RFC1034] section 6.1.

In practice, there is no distinction between the formats defined in
[@!RFC1034] section 3.6.1 and [@!RFC1035] section 5.1 and the term
"presentation format" is frequently used instead. [@!RFC8499] section 5
formally consolidates both definitions by stating it is the text format used
in master files as shown, not formally defined, in [@!RFC1034] or [@!RFC1035].


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

FIXME: (from @partim) The ABNF in [@!RFC9460] requires you to escape all
       special characters (i.e., DQUOTE, ";", "(", ")", and "\") in a quoted
       character-string when RFC 1035 explicitly only requires DQUOTE to be
       escaped (presumably also "\" even if it doesn’t say so). A patch can
       be found here: https://github.com/MikeBishop/dns-alt-svc/pull/396/files


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
