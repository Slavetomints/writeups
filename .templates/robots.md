***INTRO*** `/robots.txt`. [RFC 9309](https://www.rfc-editor.org/rfc/rfc9309.txt) Defines the **Robots Exclusion Protocol** which says:

>    This document applies to services that provide resources that clients
>   can access through URIs as defined in [RFC3986].  For example, in the
>   context of HTTP, a browser is a client that displays the content of a
>   web page.
>
>   Crawlers are automated clients.  Search engines, for instance, have
>   crawlers to recursively traverse links for indexing as defined in
>   [RFC8288].
>
>   It may be inconvenient for service owners if crawlers visit the
>   entirety of their URI space.  This document specifies the rules
>   originally defined by the "Robots Exclusion Protocol" [ROBOTSTXT]
>   that crawlers are requested to honor when accessing URIs.
>
>   These rules are not a form of access authorization.
> 
>   Internet Engineering Task Force (IETF) September 2022
> 

In basic terms, you can stop crawlers by defining rules in a file called `/robots.txt`. However, `/robots.txt` is not a valid security measure. It is based on User-Agents, which are easily spoofable. The RFC even mentions this:

>  The Robots Exclusion Protocol is not a substitute for valid content
>  security measures.  Listing paths in the robots.txt file exposes them
>  publicly and thus makes the paths discoverable.  To control access to
>  the URI paths in a robots.txt file, users of the protocol should
>  employ a valid security measure relevant to the application layer on
>  which the robots.txt file is served -- for example, in the case of
>  HTTP, HTTP Authentication as defined in [RFC9110].