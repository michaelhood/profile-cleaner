VERSION = 2.25
PN = profile-cleaner

PREFIX ?= /usr
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1

RM = @rm
SED = sed

all:
	@echo -e '\033[1;32mSetting version\033[0m'
	@sed 's/@VERSION@/'$(VERSION)'/' common/$(PN).in > common/$(PN)

install-bin:
	@echo -e '\033[1;32mInstalling main script, initd and config...\033[0m'
	install -Dm755 common/$(PN) "$(DESTDIR)$(BINDIR)/$(PN)"
	ln -s $(PN) "$(DESTDIR)$(BINDIR)/pc"

install-man:
	@echo -e '\033[1;32mInstalling manpage...\033[0m'
	install -Dm644 doc/pc.1 "$(DESTDIR)$(MANDIR)/pc.1"
	gzip -9 "$(DESTDIR)$(MANDIR)/pc.1"
	ln -s pc.1.gz "$(DESTDIR)$(MANDIR)/$(PN).1.gz"

uninstall:
	$(RM) "$(DESTDIR)$(BINDIR)/$(PN)"
	$(RM) "$(DESTDIR)$(BINDIR)/pc"
	$(RM) "$(DESTDIR)$(MANDIR)/$(PN).1.gz"
	$(RM) "$(DESTDIR)$(MANDIR)/pc.1.gz"

install: install-bin install-man

clean: $(RM) -f common/$(PN)

.PHONY: install-bin install-man uninstall install clean
