DRAFT = draft-koekkoek-dnsop-zone-file-format
VERSION = 00

XML=$(DRAFT).xml
HTML=$(DRAFT)-$(VERSION).html
TXT=$(DRAFT)-$(VERSION).txt

.PHONY: all clean

all: $(HTML) $(TXT)

pages: $(HTML) $(TXT)
	cp -p $(TXT) docs/$(TXT)
	cp -p $(HTML) docs/$(HTML)

$(HTML): $(XML)
	xml2rfc --html -o $@ $<

$(TXT): $(XML)
	xml2rfc --text -o $@ $<

$(XML): $(DRAFT).md
	today=$$(TZ=UTC date +%Y-%m-%dT00:00:00Z); \
	sed -e "s/@DOCNAME@/$(DRAFT)-$(VERSION)/g" \
	    -e "s/@TODAY@/$${today}/g"  $< | mmark > $@ || rm -f $@

clean:
	rm -f $(XML) $(HTML) $(TXT)
