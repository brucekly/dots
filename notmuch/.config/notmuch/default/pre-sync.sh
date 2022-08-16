#!/bin/sh
set -euo pipefail
IFS=$'\n\t'

notmuch search --output=files \
	'(folder:gmail/INBOX and not tag:inbox)' \
	or '(folder:gmail/\[Gmail\]/Spam and not tag:spam)' \
    | xargs -I'{}' bash -c \
	    'mv "{}" "$HOME/mail/gmail/[Gmail]/All Mail/cur/$(basename "{}" | sed -E 's/,U=.*$//')"'

notmuch search --output=files \
	'(folder:university/INBOX and not tag:inbox)' \
	or '(folder:university/Junk\ Email and not tag:spam)' \
    | xargs -I'{}' bash -c \
	    'mv "{}" "$HOME/mail/university/Archive/cur/$(basename "{}" | sed -E 's/,U=.*$//')"'

notmuch search --output=files \
	tag:inbox and 'folder:/^gmail/' and not folder:gmail/INBOX \
    | xargs -I'{}' bash -c \
	    'mv "{}" "$HOME/mail/gmail/INBOX/cur/$(basename "{}" | sed -E 's/,U=.*$//')"'

notmuch search --output=files \
	tag:inbox and 'folder:/^university/' and not folder:university/INBOX \
    | xargs -I'{}' bash -c \
	    'mv "{}" "$HOME/mail/university/Trash/cur/$(basename "{}" | sed -E 's/,U=.*$//')"'

notmuch search --output=files \
	tag:del and 'folder:/^gmail/' and not folder:gmail/\[Gmail\]/Trash \
    | xargs -I'{}' bash -c \
	    'mv "{}" "$HOME/mail/gmail/[Gmail]/Trash/cur/$(basename "{}" | sed -E 's/,U=.*$//')"'

notmuch search --output=files \
	tag:del and 'folder:/^university/' and not folder:university/Trash \
    | xargs -I'{}' bash -c \
	    'mv "{}" "$HOME/mail/university/Trash/cur/$(basename "{}" | sed -E 's/,U=.*$//')"'

notmuch search --output=files \
	tag:spam and 'folder:/^gmail/' and not folder:gmail/\[Gmail\]/Spam \
    | xargs -I'{}' bash -c \
	    'mv "{}" "$HOME/mail/gmail/[Gmail]/Spam/cur/$(basename "{}" | sed -E 's/,U=.*$//')"'

notmuch search --output=files \
	tag:spam and 'folder:/^university/' and not folder:university/Junk\ Email \
    | xargs -I'{}' bash -c \
	    'mv "{}" "$HOME/mail/university/Junk\ Email//cur/$(basename "{}" | sed -E 's/,U=.*$//')"'
