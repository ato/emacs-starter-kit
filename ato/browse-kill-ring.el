<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: browse-kill-ring.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=browse-kill-ring.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: browse-kill-ring.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=browse-kill-ring.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for browse-kill-ring.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=browse-kill-ring.el" /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22browse-kill-ring.el%22">browse-kill-ring.el</a></h1></div><div class="wrapper"><div class="content browse"><p><a href="http://www.emacswiki.org/emacs/download/browse-kill-ring.el">Download</a></p><pre class="code"><span class="linecomment">;;; browse-kill-ring.el --- interactively insert items from kill-ring -*- coding: utf-8 -*-</span>

<span class="linecomment">;; Copyright (C) 2001, 2002 Colin Walters &lt;walters@verbum.org&gt;</span>

<span class="linecomment">;; Author: Colin Walters &lt;walters@verbum.org&gt;</span>
<span class="linecomment">;; Maintainer: Nick Hurley &lt;hurley@cis.ohio-state.edu&gt;</span>
<span class="linecomment">;; Created: 7 Apr 2001</span>
<span class="linecomment">;; Version: 1.3a (CVS)</span>
<span class="linecomment">;; X-RCS: $Id: browse-kill-ring.el,v 1.2 2008/10/29 00:23:00 hurley Exp $</span>
<span class="linecomment">;; URL: http://freedom.cis.ohio-state.edu/~hurley/</span>
<span class="linecomment">;; URL-ja: http://www.fan.gr.jp/~ring/doc/browse-kill-ring.html</span>
<span class="linecomment">;; Keywords: convenience</span>

<span class="linecomment">;; This file is not currently part of GNU Emacs.</span>

<span class="linecomment">;; This program is free software; you can redistribute it and/or</span>
<span class="linecomment">;; modify it under the terms of the GNU General Public License as</span>
<span class="linecomment">;; published by the Free Software Foundation; either version 2, or (at</span>
<span class="linecomment">;; your option) any later version.</span>

<span class="linecomment">;; This program is distributed in the hope that it will be useful, but</span>
<span class="linecomment">;; WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU</span>
<span class="linecomment">;; General Public License for more details.</span>

<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with this program ; see the file COPYING.  If not, write to</span>
<span class="linecomment">;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,</span>
<span class="linecomment">;; Boston, MA 02111-1307, USA.</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; Ever feel that 'C-y M-y M-y M-y ...' is not a great way of trying</span>
<span class="linecomment">;; to find that piece of text you know you killed a while back?  Then</span>
<span class="linecomment">;; browse-kill-ring.el is for you.</span>

<span class="linecomment">;; This package is simple to install; add (require 'browse-kill-ring)</span>
<span class="linecomment">;; to your ~/.emacs file, after placing this file somewhere in your</span>
<span class="linecomment">;; `load-path'.  If you want to use 'M-y' to invoke</span>
<span class="linecomment">;; `browse-kill-ring', also add (browse-kill-ring-default-keybindings)</span>
<span class="linecomment">;; to your ~/.emacs file.  Alternatively, you can bind it to another</span>
<span class="linecomment">;; key such as "C-c k", with:</span>
<span class="linecomment">;; (global-set-key (kbd "C-c k") 'browse-kill-ring)</span>

<span class="linecomment">;; Note that the command keeps track of the last window displayed to</span>
<span class="linecomment">;; handle insertion of chosen text; this might have unexpected</span>
<span class="linecomment">;; consequences if you do 'M-x browse-kill-ring', then switch your</span>
<span class="linecomment">;; window configuration, and try to use the same *Kill Ring* buffer</span>
<span class="linecomment">;; again.</span>

<span class="linecomment">;;; Change Log:</span>

<span class="linecomment">;; Changes from 1.3 to 1.3a:</span>

<span class="linecomment">;; * Sneak update by Benjamin Andresen &lt;bandresen@gmail.com&gt;</span>
<span class="linecomment">;; * Added the read-only bugfix (http://bugs.debian.org/225082) from </span>
<span class="linecomment">;;   the emacs-goodies-el package</span>

<span class="linecomment">;; Changes from 1.2 to 1.3:</span>

<span class="linecomment">;; * New maintainer, Nick Hurley &lt;hurley@cis.ohio-state.edu&gt;</span>
<span class="linecomment">;; * New functions `browse-kill-ring-prepend-insert', and</span>
<span class="linecomment">;;   `browse-kill-ring-append-insert', bound to 'b' and 'a' by</span>
<span class="linecomment">;;   default. There are also the unbound functions</span>
<span class="linecomment">;;   `browse-kill-ring-prepend-insert-and-quit',</span>
<span class="linecomment">;;   `browse-kill-ring-prepend-insert-and-move',</span>
<span class="linecomment">;;   `browse-kill-ring-prepend-insert-move-and-quit',</span>
<span class="linecomment">;;   `browse-kill-ring-append-insert-and-quit',</span>
<span class="linecomment">;;   `browse-kill-ring-append-insert-and-move',</span>
<span class="linecomment">;;   `browse-kill-ring-append-insert-move-and-quit'.</span>

<span class="linecomment">;; Changes from 1.1 to 1.2:</span>

<span class="linecomment">;; * New variable `browse-kill-ring-resize-window', which controls</span>
<span class="linecomment">;;   whether or not the browse-kill-ring window will try to resize</span>
<span class="linecomment">;;   itself to fit the buffer.  Implementation from Juanma Barranquero</span>
<span class="linecomment">;;   &lt;lektu@terra.es&gt;.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-highlight-inserted-item'.</span>
<span class="linecomment">;;   Implementation from Yasutaka SHINDOH &lt;ring-pub@fan.gr.jp&gt;.</span>
<span class="linecomment">;; * `browse-kill-ring-mouse-insert' (normally bound to mouse-2) now</span>
<span class="linecomment">;;   calls `browse-kill-ring-quit'.</span>
<span class="linecomment">;; * Some non-user-visible code cleanup.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-recenter', implementation from</span>
<span class="linecomment">;;   René Kyllingstad &lt;kyllingstad@users.sourceforge.net&gt;.</span>
<span class="linecomment">;; * Patch from Michal Maršuka &lt;mmc@maruska.dyndns.org&gt; which handles</span>
<span class="linecomment">;;   read-only text better.</span>
<span class="linecomment">;; * New ability to move unkilled entries back to the beginning of the</span>
<span class="linecomment">;;   ring; patch from Yasutaka SHINDOH &lt;ring-pub@fan.gr.jp&gt;.</span>
<span class="linecomment">;; * Do nothing if the user invokes `browse-kill-ring' when we're</span>
<span class="linecomment">;;   already in a *Kill Ring* buffer (initial patch from Juanma</span>
<span class="linecomment">;;   Barranquero &lt;lektu@terra.es&gt;).</span>

<span class="linecomment">;; Changes from 1.0 to 1.1:</span>

<span class="linecomment">;; * Important keybinding change!  The default bindings of RET and 'i'</span>
<span class="linecomment">;;   have switched; this means typing RET now by default inserts the</span>
<span class="linecomment">;;   text and calls `browse-kill-ring-quit'; 'i' just inserts.</span>
<span class="linecomment">;; * The variable `browse-kill-ring-use-fontification' is gone;</span>
<span class="linecomment">;;   browse-kill-ring.el has been rewritten to use font-lock.  XEmacs</span>
<span class="linecomment">;;   users who want fontification will have to do:</span>
<span class="linecomment">;;   (add-hook 'browse-kill-ring-hook 'font-lock-mode)</span>
<span class="linecomment">;; * Integrated code from Michael Slass &lt;mikesl@wrq.com&gt; into</span>
<span class="linecomment">;;   `browse-kill-ring-default-keybindings'.</span>
<span class="linecomment">;; * New Japanese homepage for browse-kill-ring.el, thanks to</span>
<span class="linecomment">;;   Yasutaka SHINDOH &lt;ring-pub@fan.gr.jp&gt;.</span>
<span class="linecomment">;; * Correctly restore window configuration after editing an entry.</span>
<span class="linecomment">;; * New command `browse-kill-ring-insert-and-delete'.</span>
<span class="linecomment">;; * Bug reports and patches from Michael Slass &lt;mikesl@wrq.com&gt; and</span>
<span class="linecomment">;;   Juanma Barranquero &lt;lektu@terra.es&gt;.</span>

<span class="linecomment">;; Changes from 0.9b to 1.0:</span>

<span class="linecomment">;; * Add autoload cookie to `browse-kill-ring'; suggestion from</span>
<span class="linecomment">;;   D. Goel &lt;deego@glue.umd.edu&gt; and Dave Pearson &lt;davep@davep.org&gt;.</span>
<span class="linecomment">;; * Add keybinding tip from Michael Slass &lt;mikesl@wrq.com&gt;.</span>

<span class="linecomment">;; Changes from 0.9a to 0.9b:</span>

<span class="linecomment">;; * Remove extra parenthesis.  Duh.</span>

<span class="linecomment">;; Changes from 0.9 to 0.9a:</span>

<span class="linecomment">;; * Fix bug making `browse-kill-ring-quit-action' uncustomizable.</span>
<span class="linecomment">;;   Patch from Henrik Enberg &lt;henrik@enberg.org&gt;.</span>
<span class="linecomment">;; * Add `url-link' and `group' attributes to main Customization</span>
<span class="linecomment">;;   group.</span>

<span class="linecomment">;; Changes from 0.8 to 0.9:</span>

<span class="linecomment">;; * Add new function `browse-kill-ring-insert-and-quit', bound to 'i'</span>
<span class="linecomment">;;   by default (idea from Yasutaka Shindoh).</span>
<span class="linecomment">;; * Make default `browse-kill-ring-quit-action' be</span>
<span class="linecomment">;;   `bury-and-delete-window', which handles the case of a single window</span>
<span class="linecomment">;;   more nicely.</span>
<span class="linecomment">;; * Note change of home page and author address.</span>

<span class="linecomment">;; Changes from 0.7 to 0.8:</span>

<span class="linecomment">;; * Fix silly bug in `browse-kill-ring-edit' which made it impossible</span>
<span class="linecomment">;;   to edit entries.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-quit-action'.</span>
<span class="linecomment">;; * `browse-kill-ring-restore' renamed to `browse-kill-ring-quit'.</span>
<span class="linecomment">;; * Describe the keymaps in mode documentation.  Patch from</span>
<span class="linecomment">;;   Marko Slyz &lt;mslyz@eecs.umich.edu&gt;.</span>
<span class="linecomment">;; * Fix advice documentation for `browse-kill-ring-no-duplicates'.</span>

<span class="linecomment">;; Changes from 0.6 to 0.7:</span>

<span class="linecomment">;; * New functions `browse-kill-ring-search-forward' and</span>
<span class="linecomment">;;   `browse-kill-ring-search-backward', bound to "s" and "r" by</span>
<span class="linecomment">;;   default, respectively.</span>
<span class="linecomment">;; * New function `browse-kill-ring-edit' bound to "e" by default, and</span>
<span class="linecomment">;;   a associated new major mode.</span>
<span class="linecomment">;; * New function `browse-kill-ring-occur', bound to "l" by default.</span>

<span class="linecomment">;; Changes from 0.5 to 0.6:</span>

<span class="linecomment">;; * Fix bug in `browse-kill-ring-forward' which sometimes would cause</span>
<span class="linecomment">;;   a message "Wrong type argument: overlayp, nil" to appear.</span>
<span class="linecomment">;; * New function `browse-kill-ring-update'.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-highlight-current-entry'.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-display-duplicates'.</span>
<span class="linecomment">;; * New optional advice `browse-kill-ring-no-kill-new-duplicates',</span>
<span class="linecomment">;;   and associated variable `browse-kill-ring-no-duplicates'.  Code</span>
<span class="linecomment">;;   from Klaus Berndl &lt;Klaus.Berndl@sdm.de&gt;.</span>
<span class="linecomment">;; * Bind "?" to `describe-mode'.  Patch from Dave Pearson</span>
<span class="linecomment">;;   &lt;dave@davep.org&gt;.</span>
<span class="linecomment">;; * Fix typo in `browse-kill-ring-display-style' defcustom form.</span>
<span class="linecomment">;;   Thanks "Kahlil (Kal) HODGSON" &lt;kahlil@discus.anu.edu.au&gt;.</span>

<span class="linecomment">;; Changes from 0.4 to 0.5:</span>

<span class="linecomment">;; * New function `browse-kill-ring-delete', bound to "d" by default.</span>
<span class="linecomment">;; * New function `browse-kill-ring-undo', bound to "U" by default.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-maximum-display-length'.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-use-fontification'.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-hook', called after the</span>
<span class="linecomment">;;   "*Kill Ring*" buffer is created.</span>

<span class="linecomment">;; Changes from 0.3 to 0.4:</span>

<span class="linecomment">;; * New functions `browse-kill-ring-forward' and</span>
<span class="linecomment">;;   `browse-kill-ring-previous', bound to "n" and "p" by default,</span>
<span class="linecomment">;;   respectively.</span>
<span class="linecomment">;; * Change the default `browse-kill-ring-display-style' to</span>
<span class="linecomment">;;   `separated'.</span>
<span class="linecomment">;; * Removed `browse-kill-ring-original-window-config'; Now</span>
<span class="linecomment">;;   `browse-kill-ring-restore' just buries the "*Kill Ring*" buffer</span>
<span class="linecomment">;;   and deletes its window, which is simpler and more intuitive.</span>
<span class="linecomment">;; * New variable `browse-kill-ring-separator-face'.</span>

<span class="linecomment">;;; Bugs:</span>

<span class="linecomment">;; * Sometimes, in Emacs 21, the cursor will jump to the end of an</span>
<span class="linecomment">;;   entry when moving backwards using `browse-kill-ring-previous'.</span>
<span class="linecomment">;;   This doesn't seem to occur in Emacs 20 or XEmacs.</span>

<span class="linecomment">;;; Code:</span>

(eval-when-compile
  (require 'cl)
  (require 'derived))

(when (featurep 'xemacs)
  (require 'overlay))

(defun browse-kill-ring-depropertize-string (str)
  "<span class="quote">Return a copy of STR with text properties removed.</span>"
  (let ((str (copy-sequence str)))
    (set-text-properties 0 (length str) nil str)
    str))

(cond ((fboundp 'propertize)
       (defalias 'browse-kill-ring-propertize 'propertize))
      <span class="linecomment">;; Maybe save some memory :)</span>
      ((fboundp 'ibuffer-propertize)
       (defalias 'browse-kill-ring-propertize 'ibuffer-propertize))
      (t
       (defun browse-kill-ring-propertize (string &rest properties)
	 "<span class="quote">Return a copy of STRING with text properties added.

 [Note: this docstring has been copied from the Emacs 21 version]

First argument is the string to copy.
Remaining arguments form a sequence of PROPERTY VALUE pairs for text
properties to add to the result.</span>"
	 (let ((str (copy-sequence string)))
	   (add-text-properties 0 (length str)
				properties
				str)
	   str))))

(defgroup browse-kill-ring nil
  "<span class="quote">A package for browsing and inserting the items in `kill-ring'.</span>"
  :link '(url-link "<span class="quote">http://freedom.cis.ohio-state.edu/~hurley/</span>")
  :group 'convenience)

(defvar browse-kill-ring-display-styles
  '((separated . browse-kill-ring-insert-as-separated)
    (one-line . browse-kill-ring-insert-as-one-line)))

(defcustom browse-kill-ring-display-style 'separated
  "<span class="quote">How to display the kill ring items.

If `one-line', then replace newlines with \"\\n\" for display.

If `separated', then display `browse-kill-ring-separator' between
entries.</span>"
  :type '(choice (const :tag "<span class="quote">One line</span>" one-line)
		 (const :tag "<span class="quote">Separated</span>" separated))
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-quit-action 'bury-and-delete-window
  "<span class="quote">What action to take when `browse-kill-ring-quit' is called.

If `bury-buffer', then simply bury the *Kill Ring* buffer, but keep
the window.

If `bury-and-delete-window', then bury the buffer, and (if there is
more than one window) delete the window.  This is the default.

If `save-and-restore', then save the window configuration when
`browse-kill-ring' is called, and restore it at quit.

If `kill-and-delete-window', then kill the *Kill Ring* buffer, and
delete the window on close.

Otherwise, it should be a function to call.</span>"
  :type '(choice (const :tag "<span class="quote">Bury buffer</span>" :value bury-buffer)
		 (const :tag "<span class="quote">Delete window</span>" :value delete-window)
		 (const :tag "<span class="quote">Save and restore</span>" :value save-and-restore)
		 (const :tag "<span class="quote">Bury buffer and delete window</span>" :value bury-and-delete-window)
		 (const :tag "<span class="quote">Kill buffer and delete window</span>" :value kill-and-delete-window)
		 function)
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-resize-window nil
  "<span class="quote">Whether to resize the `browse-kill-ring' window to fit its contents.
Value is either t, meaning yes, or a cons pair of integers,
 (MAXIMUM . MINIMUM) for the size of the window.  MAXIMUM defaults to
the window size chosen by `pop-to-buffer'; MINIMUM defaults to
`window-min-height'.</span>"
  :type '(choice (const :tag "<span class="quote">No</span>" nil)
		 (const :tag "<span class="quote">Yes</span>" t)
		 (cons (integer :tag "<span class="quote">Maximum</span>") (integer :tag "<span class="quote">Minimum</span>")))
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-separator "<span class="quote">-------</span>"
  "<span class="quote">The string separating entries in the `separated' style.
See `browse-kill-ring-display-style'.</span>"
  :type 'string
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-recenter nil
  "<span class="quote">If non-nil, then always keep the current entry at the top of the window.</span>"
  :type 'boolean
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-highlight-current-entry nil
  "<span class="quote">If non-nil, highlight the currently selected `kill-ring' entry.</span>"
  :type 'boolean
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-highlight-inserted-item browse-kill-ring-highlight-current-entry
  "<span class="quote">If non-nil, temporarily highlight the inserted `kill-ring' entry.</span>"
  :type 'boolean
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-separator-face 'bold
  "<span class="quote">The face in which to highlight the `browse-kill-ring-separator'.</span>"
  :type 'face
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-maximum-display-length nil
  "<span class="quote">Whether or not to limit the length of displayed items.

If this variable is an integer, the display of `kill-ring' will be
limited to that many characters.
Setting this variable to nil means no limit.</span>"
  :type '(choice (const :tag "<span class="quote">None</span>" nil)
		 integer)
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-display-duplicates t
  "<span class="quote">If non-nil, then display duplicate items in `kill-ring'.</span>"
  :type 'boolean
  :group 'browse-kill-ring)

(defadvice kill-new (around browse-kill-ring-no-kill-new-duplicates)
  "<span class="quote">An advice for not adding duplicate elements to `kill-ring'.
Even after being \"activated\", this advice will only modify the
behavior of `kill-new' when `browse-kill-ring-no-duplicates'
is non-nil.</span>"
  (if browse-kill-ring-no-duplicates
      (setq kill-ring (delete (ad-get-arg 0) kill-ring)))
  ad-do-it)

(defcustom browse-kill-ring-no-duplicates nil
  "<span class="quote">If non-nil, then the `b-k-r-no-kill-new-duplicates' advice will operate.
This means that duplicate entries won't be added to the `kill-ring'
when you call `kill-new'.

If you set this variable via customize, the advice will be activated
or deactivated automatically.  Otherwise, to enable the advice, add

 (ad-enable-advice 'kill-new 'around 'browse-kill-ring-no-kill-new-duplicates)
 (ad-activate 'kill-new)

to your init file.</span>"
  :type 'boolean
  :set (lambda (symbol value)
         (set symbol value)
         (if value
             (ad-enable-advice 'kill-new 'around
			       'browse-kill-ring-no-kill-new-duplicates)
           (ad-disable-advice 'kill-new 'around
			      'browse-kill-ring-no-kill-new-duplicates))
         (ad-activate 'kill-new))
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-depropertize nil
  "<span class="quote">If non-nil, remove text properties from `kill-ring' items.
This only changes the items for display and insertion from
`browse-kill-ring'; if you call `yank' directly, the items will be
inserted with properties.</span>"
  :type 'boolean
  :group 'browse-kill-ring)

(defcustom browse-kill-ring-hook nil
  "<span class="quote">A list of functions to call after `browse-kill-ring'.</span>"
  :type 'hook
  :group 'browse-kill-ring)

(defvar browse-kill-ring-original-window-config nil
  "<span class="quote">The window configuration to restore for `browse-kill-ring-quit'.</span>")
(make-variable-buffer-local 'browse-kill-ring-original-window-config)

(defvar browse-kill-ring-original-window nil
  "<span class="quote">The window in which chosen kill ring data will be inserted.
It is probably not a good idea to set this variable directly; simply
call `browse-kill-ring' again.</span>")

(defun browse-kill-ring-mouse-insert (e)
  "<span class="quote">Insert the chosen text, and close the *Kill Ring* buffer afterwards.</span>"
  (interactive "<span class="quote">e</span>")
  (let* ((data (save-excursion
		 (mouse-set-point e)
		 (cons (current-buffer) (point))))
	 (buf (car data))
	 (pt (cdr data)))
    (browse-kill-ring-do-insert buf pt))
  (browse-kill-ring-quit))

(if (fboundp 'fit-window-to-buffer)
    (defalias 'browse-kill-ring-fit-window 'fit-window-to-buffer)
  (defun browse-kill-ring-fit-window (window max-height min-height)
    (setq min-height (or min-height window-min-height))
    (setq max-height (or max-height (- (frame-height) (window-height) 1)))
    (let* ((window-min-height min-height)
           (windows (count-windows))
           (config (current-window-configuration)))
      (enlarge-window (- max-height (window-height)))
      (when (&gt; windows (count-windows))
        (set-window-configuration config))
      (if (/= (point-min) (point-max))
          (shrink-window-if-larger-than-buffer window)
        (shrink-window (- (window-height) window-min-height))))))

(defun browse-kill-ring-resize-window ()
  (when browse-kill-ring-resize-window
    (apply #'browse-kill-ring-fit-window (selected-window)
	   (if (consp browse-kill-ring-resize-window)
	       (list (car browse-kill-ring-resize-window)
		     (or (cdr browse-kill-ring-resize-window)
			 window-min-height))
	     (list nil window-min-height)))))

(defun browse-kill-ring-undo-other-window ()
  "<span class="quote">Undo the most recent change in the other window's buffer.
You most likely want to use this command for undoing an insertion of
yanked text from the *Kill Ring* buffer.</span>"
  (interactive)
  (with-current-buffer (window-buffer browse-kill-ring-original-window)
    (undo)))

(defun browse-kill-ring-insert (&optional quit)
  "<span class="quote">Insert the kill ring item at point into the last selected buffer.
If optional argument QUIT is non-nil, close the *Kill Ring* buffer as
well.</span>"
  (interactive "<span class="quote">P</span>")
  (browse-kill-ring-do-insert (current-buffer)
			      (point))
  (when quit
    (browse-kill-ring-quit)))

(defun browse-kill-ring-insert-and-delete (&optional quit)
  "<span class="quote">Insert the kill ring item at point, and remove it from the kill ring.
If optional argument QUIT is non-nil, close the *Kill Ring* buffer as
well.</span>"
  (interactive "<span class="quote">P</span>")
  (browse-kill-ring-do-insert (current-buffer)
			      (point))
  (browse-kill-ring-delete)
  (when quit
    (browse-kill-ring-quit)))

(defun browse-kill-ring-insert-and-quit ()
  "<span class="quote">Like `browse-kill-ring-insert', but close the *Kill Ring* buffer afterwards.</span>"
  (interactive)
  (browse-kill-ring-insert t))

(defun browse-kill-ring-insert-and-move (&optional quit)
  "<span class="quote">Like `browse-kill-ring-insert', but move the entry to the front.</span>"
  (interactive "<span class="quote">P</span>")
  (let ((buf (current-buffer))
 	(pt (point)))
    (browse-kill-ring-do-insert buf pt)
    (let ((str (browse-kill-ring-current-string buf pt)))
      (browse-kill-ring-delete)
      (kill-new str)))
  (if quit
      (browse-kill-ring-quit)
    (browse-kill-ring-update)))

(defun browse-kill-ring-insert-move-and-quit ()
  "<span class="quote">Like `browse-kill-ring-insert-and-move', but close the *Kill Ring* buffer.</span>"
  (interactive)
  (browse-kill-ring-insert-and-move t))

(defun browse-kill-ring-prepend-insert (&optional quit)
  "<span class="quote">Like `browse-kill-ring-insert', but it places the entry at the beginning
of the buffer as opposed to point.</span>"
  (interactive "<span class="quote">P</span>")
  (browse-kill-ring-do-prepend-insert (current-buffer)
				      (point))
  (when quit
    (browse-kill-ring-quit)))

(defun browse-kill-ring-prepend-insert-and-quit ()
  "<span class="quote">Like `browse-kill-ring-prepend-insert', but close the *Kill Ring* buffer.</span>"
  (interactive)
  (browse-kill-ring-prepend-insert t))

(defun browse-kill-ring-prepend-insert-and-move (&optional quit)
  "<span class="quote">Like `browse-kill-ring-prepend-insert', but move the entry to the front
of the *Kill Ring*.</span>"
  (interactive "<span class="quote">P</span>")
  (let ((buf (current-buffer))
	(pt (point)))
    (browse-kill-ring-do-prepend-insert buf pt)
    (let ((str (browse-kill-ring-current-string buf pt)))
      (browse-kill-ring-delete)
      (kill-new str)))
  (if quit
      (browse-kill-ring-quit)
    (browse-kill-ring-update)))

(defun browse-kill-ring-prepend-insert-move-and-quit ()
  "<span class="quote">Like `browse-kill-ring-prepend-insert-and-move', but close the
*Kill Ring* buffer.</span>"
  (interactive)
  (browse-kill-ring-prepend-insert-and-move t))

(defun browse-kill-ring-do-prepend-insert (buf pt)
  (let ((str (browse-kill-ring-current-string buf pt)))
    (let ((orig (current-buffer)))
      (unwind-protect
	  (progn
	    (unless (window-live-p browse-kill-ring-original-window)
	      (error "<span class="quote">Window %s has been deleted; Try calling `browse-kill-ring' again</span>"
		     browse-kill-ring-original-window))
	    (set-buffer (window-buffer browse-kill-ring-original-window))
	    (save-excursion
	      (let ((pt (point)))
		(goto-char (point-min))
		(insert (if browse-kill-ring-depropertize
			    (browse-kill-ring-depropertize-string str)
			  str))
		(when browse-kill-ring-highlight-inserted-item
		  (let ((o (make-overlay (point-min) (point))))
		    (overlay-put o 'face 'highlight)
		    (sit-for 0.5)
		    (delete-overlay o)))
		(goto-char pt))))
	(set-buffer orig)))))

(defun browse-kill-ring-append-insert (&optional quit)
  "<span class="quote">Like `browse-kill-ring-insert', but places the entry at the end of the
buffer as opposed to point.</span>"
  (interactive "<span class="quote">P</span>")
  (browse-kill-ring-do-append-insert (current-buffer)
				     (point))
  (when quit
    (browse-kill-ring-quit)))

(defun browse-kill-ring-append-insert-and-quit ()
  "<span class="quote">Like `browse-kill-ring-append-insert', but close the *Kill Ring* buffer.</span>"
  (interactive)
  (browse-kill-ring-append-insert t))

(defun browse-kill-ring-append-insert-and-move (&optional quit)
  "<span class="quote">Like `browse-kill-ring-append-insert', but move the entry to the front
of the *Kill Ring*.</span>"
  (interactive "<span class="quote">P</span>")
  (let ((buf (current-buffer))
	(pt (point)))
    (browse-kill-ring-do-append-insert buf pt)
    (let ((str (browse-kill-ring-current-string buf pt)))
      (browse-kill-ring-delete)
      (kill-new str)))
  (if quit
      (browse-kill-ring-quit)
    (browse-kill-ring-update)))

(defun browse-kill-ring-append-insert-move-and-quit ()
  "<span class="quote">Like `browse-kill-ring-append-insert-and-move', but close the
*Kill Ring* buffer.</span>"
  (interactive)
  (browse-kill-ring-append-insert-and-move t))

(defun browse-kill-ring-do-append-insert (buf pt)
  (let ((str (browse-kill-ring-current-string buf pt)))
    (let ((orig (current-buffer)))
      (unwind-protect
	  (progn
	    (unless (window-live-p browse-kill-ring-original-window)
	      (error "<span class="quote">Window %s has been deleted; Try calling `browse-kill-ring' again</span>"
		     browse-kill-ring-original-window))
	    (set-buffer (window-buffer browse-kill-ring-original-window))
	    (save-excursion
	      (let ((pt (point))
		    (begin-pt (point-max)))
		(goto-char begin-pt)
		(insert (if browse-kill-ring-depropertize
			    (browse-kill-ring-depropertize-string str)
			  str))
		(when browse-kill-ring-highlight-inserted-item
		  (let ((o (make-overlay begin-pt (point-max))))
		    (overlay-put o 'face 'highlight)
		    (sit-for 0.5)
		    (delete-overlay o)))
		(goto-char pt))))
	(set-buffer orig)))))

(defun browse-kill-ring-delete ()
  "<span class="quote">Remove the item at point from the `kill-ring'.</span>"
  (interactive)
  (let ((over (car (overlays-at (point)))))
    (unless (overlayp over)
      (error "<span class="quote">No kill ring item here</span>"))
    (unwind-protect
	(progn
	  (setq buffer-read-only nil)
	  (let ((target (overlay-get over 'browse-kill-ring-target)))
	    (delete-region (overlay-start over)
			   (1+ (overlay-end over)))
	    (setq kill-ring (delete target kill-ring)))
	  (when (get-text-property (point) 'browse-kill-ring-extra)
	    (let ((prev (previous-single-property-change (point)
							 'browse-kill-ring-extra))
		  (next (next-single-property-change (point)
						     'browse-kill-ring-extra)))
	      <span class="linecomment">;; This is some voodoo.</span>
	      (when prev
		(incf prev))
	      (when next
		(incf next))
	      (delete-region (or prev (point-min))
			     (or next (point-max))))))
      (setq buffer-read-only t)))
  (browse-kill-ring-resize-window)
  (browse-kill-ring-forward 0))

(defun browse-kill-ring-current-string (buf pt)
  (with-current-buffer buf
    (let ((overs (overlays-at pt)))
      (or (and overs
	       (overlay-get (car overs) 'browse-kill-ring-target))
 	  (error "<span class="quote">No kill ring item here</span>")))))

(defun browse-kill-ring-do-insert (buf pt)
  (let ((str (browse-kill-ring-current-string buf pt)))
    (let ((orig (current-buffer)))
      (unwind-protect
	  (progn
	    (unless (window-live-p browse-kill-ring-original-window)
	      (error "<span class="quote">Window %s has been deleted; Try calling `browse-kill-ring' again</span>"
		     browse-kill-ring-original-window))
	    (set-buffer (window-buffer browse-kill-ring-original-window))
	    (save-excursion
	      (let ((pt (point)))
		(insert (if browse-kill-ring-depropertize
			    (browse-kill-ring-depropertize-string str)
			  str))
		(when browse-kill-ring-highlight-inserted-item
		  (let ((o (make-overlay pt (point))))
		    (overlay-put o 'face 'highlight)
		    (sit-for 0.5)
		    (delete-overlay o))))))
	(set-buffer orig)))))

(defun browse-kill-ring-forward (&optional arg)
  "<span class="quote">Move forward by ARG `kill-ring' entries.</span>"
  (interactive "<span class="quote">p</span>")
  (beginning-of-line)
  (while (not (zerop arg))
    (if (&lt; arg 0)
	(progn
	  (incf arg)
	  (if (overlays-at (point))
	      (progn
		(goto-char (overlay-start (car (overlays-at (point)))))
		(goto-char (previous-overlay-change (point)))
		(goto-char (previous-overlay-change (point))))
	    (progn
	      (goto-char (1- (previous-overlay-change (point))))
	      (unless (bobp)
		(goto-char (overlay-start (car (overlays-at (point)))))))))
      (progn
	(decf arg)
	(if (overlays-at (point))
	    (progn
	      (goto-char (overlay-end (car (overlays-at (point)))))
	      (goto-char (next-overlay-change (point))))
	  (goto-char (next-overlay-change (point)))
	  (unless (eobp)
	    (goto-char (overlay-start (car (overlays-at (point))))))))))
  <span class="linecomment">;; This could probably be implemented in a more intelligent manner.</span>
  <span class="linecomment">;; Perhaps keep track over the overlay we started from?  That would</span>
  <span class="linecomment">;; break when the user moved manually, though.</span>
  (when (and browse-kill-ring-highlight-current-entry
	     (overlays-at (point)))
    (let ((overs (overlay-lists))
	  (current-overlay (car (overlays-at (point)))))
      (mapcar #'(lambda (o)
		  (overlay-put o 'face nil))
	      (nconc (car overs) (cdr overs)))
      (overlay-put current-overlay 'face 'highlight)))
  (when browse-kill-ring-recenter
    (recenter 1)))

(defun browse-kill-ring-previous (&optional arg)
  "<span class="quote">Move backward by ARG `kill-ring' entries.</span>"
  (interactive "<span class="quote">p</span>")
  (browse-kill-ring-forward (- arg)))

(defun browse-kill-ring-read-regexp (msg)
  (let* ((default (car regexp-history))
	 (input
	  (read-from-minibuffer
	   (if default
	       (format "<span class="quote">%s for regexp (default `%s'): </span>"
		       msg
		       default)
	     (format "<span class="quote">%s (regexp): </span>" msg))
	   nil
	   nil
	   nil
	   'regexp-history)))
    (if (equal input "<span class="quote"></span>")
	default
      input)))

(defun browse-kill-ring-search-forward (regexp &optional backwards)
  "<span class="quote">Move to the next `kill-ring' entry matching REGEXP from point.
If optional arg BACKWARDS is non-nil, move to the previous matching
entry.</span>"
  (interactive
   (list (browse-kill-ring-read-regexp "<span class="quote">Search forward</span>")
	 current-prefix-arg))
  (let ((orig (point)))
    (browse-kill-ring-forward (if backwards -1 1))
    (let ((overs (overlays-at (point))))
      (while (and overs
		  (not (if backwards (bobp) (eobp)))
		  (not (string-match regexp
				     (overlay-get (car overs)
						  'browse-kill-ring-target))))
	(browse-kill-ring-forward (if backwards -1 1))
	(setq overs (overlays-at (point))))
      (unless (and overs
		   (string-match regexp
				 (overlay-get (car overs)
					      'browse-kill-ring-target)))
	(progn
	  (goto-char orig)
	  (message "<span class="quote">No more `kill-ring' entries matching %s</span>" regexp))))))

(defun browse-kill-ring-search-backward (regexp)
  "<span class="quote">Move to the previous `kill-ring' entry matching REGEXP from point.</span>"
  (interactive
   (list (browse-kill-ring-read-regexp "<span class="quote">Search backward</span>")))
  (browse-kill-ring-search-forward regexp t))

(defun browse-kill-ring-quit ()
  "<span class="quote">Take the action specified by `browse-kill-ring-quit-action'.</span>"
  (interactive)
  (case browse-kill-ring-quit-action
    (save-and-restore
     (let (buf (current-buffer))
       (set-window-configuration browse-kill-ring-original-window-config)
       (kill-buffer buf)))
    (kill-and-delete-window
     (kill-buffer (current-buffer))
     (unless (= (count-windows) 1)
       (delete-window)))
    (bury-and-delete-window
     (bury-buffer)
     (unless (= (count-windows) 1)
       (delete-window)))
    (t
     (funcall browse-kill-ring-quit-action))))

(put 'browse-kill-ring-mode 'mode-class 'special)
(define-derived-mode browse-kill-ring-mode fundamental-mode
  "<span class="quote">Kill Ring</span>"
  "<span class="quote">A major mode for browsing the `kill-ring'.
You most likely do not want to call `browse-kill-ring-mode' directly; use
`browse-kill-ring' instead.

\\{browse-kill-ring-mode-map}</span>"
  (set (make-local-variable 'font-lock-defaults)
       '(nil t nil nil nil
	     (font-lock-fontify-region-function . browse-kill-ring-fontify-region)))
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">q</span>") 'browse-kill-ring-quit)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">U</span>") 'browse-kill-ring-undo-other-window)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">d</span>") 'browse-kill-ring-delete)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">s</span>") 'browse-kill-ring-search-forward)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">r</span>") 'browse-kill-ring-search-backward)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">g</span>") 'browse-kill-ring-update)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">l</span>") 'browse-kill-ring-occur)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">e</span>") 'browse-kill-ring-edit)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">n</span>") 'browse-kill-ring-forward)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">p</span>") 'browse-kill-ring-previous)
  (define-key browse-kill-ring-mode-map [(mouse-2)] 'browse-kill-ring-mouse-insert)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">?</span>") 'describe-mode)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">h</span>") 'describe-mode)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">y</span>") 'browse-kill-ring-insert)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">u</span>") 'browse-kill-ring-insert-move-and-quit)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">i</span>") 'browse-kill-ring-insert)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">o</span>") 'browse-kill-ring-insert-and-move)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">x</span>") 'browse-kill-ring-insert-and-delete)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">RET</span>") 'browse-kill-ring-insert-and-quit)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">b</span>") 'browse-kill-ring-prepend-insert)
  (define-key browse-kill-ring-mode-map (kbd "<span class="quote">a</span>") 'browse-kill-ring-append-insert))

<span class="linecomment">;;;###autoload</span>
(defun browse-kill-ring-default-keybindings ()
  "<span class="quote">Set up M-y (`yank-pop') so that it can invoke `browse-kill-ring'.
Normally, if M-y was not preceeded by C-y, then it has no useful
behavior.  This function sets things up so that M-y will invoke
`browse-kill-ring'.</span>"
  (interactive)
  (defadvice yank-pop (around kill-ring-browse-maybe (arg))
    "<span class="quote">If last action was not a yank, run `browse-kill-ring' instead.</span>"
    <span class="linecomment">;; yank-pop has an (interactive "*p") form which does not allow</span>
    <span class="linecomment">;; it to run in a read-only buffer.  We want browse-kill-ring to</span>
    <span class="linecomment">;; be allowed to run in a read only buffer, so we change the</span>
    <span class="linecomment">;; interactive form here.  In that case, we need to</span>
    <span class="linecomment">;; barf-if-buffer-read-only if we're going to call yank-pop with</span>
    <span class="linecomment">;; ad-do-it</span>
    (interactive "<span class="quote">p</span>")
    (if (not (eq last-command 'yank))
	(browse-kill-ring)
      (barf-if-buffer-read-only)
      ad-do-it))
  (ad-activate 'yank-pop))

(define-derived-mode browse-kill-ring-edit-mode fundamental-mode
  "<span class="quote">Kill Ring Edit</span>"
  "<span class="quote">A major mode for editing a `kill-ring' entry.
You most likely do not want to call `browse-kill-ring-edit-mode'
directly; use `browse-kill-ring' instead.

\\{browse-kill-ring-edit-mode-map}</span>"
  (define-key browse-kill-ring-edit-mode-map (kbd "<span class="quote">C-c C-c</span>")
    'browse-kill-ring-edit-finish))

(defvar browse-kill-ring-edit-target nil)
(make-variable-buffer-local 'browse-kill-ring-edit-target)

(defun browse-kill-ring-edit ()
  "<span class="quote">Edit the `kill-ring' entry at point.</span>"
  (interactive)
  (let ((overs (overlays-at (point))))
    (unless overs
      (error "<span class="quote">No kill ring entry here</span>"))
    (let* ((target (overlay-get (car overs)
				'browse-kill-ring-target))
	   (target-cell (member target kill-ring)))
      (unless target-cell
	(error "<span class="quote">Item deleted from the kill-ring</span>"))
      (switch-to-buffer (get-buffer-create "<span class="quote">*Kill Ring Edit*</span>"))
      (setq buffer-read-only nil)
      (erase-buffer)
      (insert target)
      (goto-char (point-min))
      (browse-kill-ring-resize-window)
      (browse-kill-ring-edit-mode)
      (message "<span class="quote">%s</span>"
	       (substitute-command-keys
		"<span class="quote">Use \\[browse-kill-ring-edit-finish] to finish editing.</span>"))
      (setq browse-kill-ring-edit-target target-cell))))

(defun browse-kill-ring-edit-finish ()
  "<span class="quote">Commit the changes to the `kill-ring'.</span>"
  (interactive)
  (if browse-kill-ring-edit-target
      (setcar browse-kill-ring-edit-target (buffer-string))
    (when (y-or-n-p "<span class="quote">The item has been deleted; add to front? </span>")
      (push (buffer-string) kill-ring)))
  (bury-buffer)
  <span class="linecomment">;; The user might have rearranged the windows</span>
  (when (eq major-mode 'browse-kill-ring-mode)
    (browse-kill-ring-setup (current-buffer)
			    browse-kill-ring-original-window
			    nil
			    browse-kill-ring-original-window-config)
    (browse-kill-ring-resize-window)))

(defmacro browse-kill-ring-add-overlays-for (item &rest body)
  (let ((beg (gensym "<span class="quote">browse-kill-ring-add-overlays-</span>"))
	(end (gensym "<span class="quote">browse-kill-ring-add-overlays-</span>")))
    `(let ((,beg (point))
	   (,end
	    (progn
	      ,@body
	      (point))))
       (let ((o (make-overlay ,beg ,end)))
	 (overlay-put o 'browse-kill-ring-target ,item)
	 (overlay-put o 'mouse-face 'highlight)))))
<span class="linecomment">;; (put 'browse-kill-ring-add-overlays-for 'lisp-indent-function 1)</span>

(defun browse-kill-ring-elide (str)
  (if (and browse-kill-ring-maximum-display-length
	   (&gt; (length str)
	      browse-kill-ring-maximum-display-length))
      (concat (substring str 0 (- browse-kill-ring-maximum-display-length 3))
	      (browse-kill-ring-propertize "<span class="quote">...</span>" 'browse-kill-ring-extra t))
    str))

(defun browse-kill-ring-insert-as-one-line (items)
  (dolist (item items)
    (browse-kill-ring-add-overlays-for item
      (let* ((item (browse-kill-ring-elide item))
	     (len (length item))
	     (start 0)
	     (newl (browse-kill-ring-propertize "<span class="quote">\\n</span>" 'browse-kill-ring-extra t)))
	(while (and (&lt; start len)
		    (string-match "<span class="quote">\n</span>" item start))
	  (insert (substring item start (match-beginning 0))
		  newl)
	  (setq start (match-end 0)))
	(insert (substring item start len))))
    (insert "<span class="quote">\n</span>")))

(defun browse-kill-ring-insert-as-separated (items)
  (while (cdr items)
    (browse-kill-ring-insert-as-separated-1 (car items) t)
    (setq items (cdr items)))
  (when items
    (browse-kill-ring-insert-as-separated-1 (car items) nil)))

(defun browse-kill-ring-insert-as-separated-1 (origitem separatep)
  (let* ((item (browse-kill-ring-elide origitem))
	 (len (length item)))
    (browse-kill-ring-add-overlays-for origitem
                                       (insert item))
    <span class="linecomment">;; When the kill-ring has items with read-only text property at</span>
    <span class="linecomment">;; **the end of** string, browse-kill-ring-setup fails with error</span>
    <span class="linecomment">;; `Text is read-only'.  So inhibit-read-only here.</span>
    <span class="linecomment">;; See http://bugs.debian.org/225082</span>
    <span class="linecomment">;; - INOUE Hiroyuki &lt;dombly@kc4.so-net.ne.jp&gt;</span>
    (let ((inhibit-read-only t))
      (insert "<span class="quote">\n</span>")
      (when separatep
        (insert (browse-kill-ring-propertize browse-kill-ring-separator
                                             'browse-kill-ring-extra t
                                             'browse-kill-ring-separator t))
        (insert "<span class="quote">\n</span>")))))

(defun browse-kill-ring-occur (regexp)
  "<span class="quote">Display all `kill-ring' entries matching REGEXP.</span>"
  (interactive
   (list
    (browse-kill-ring-read-regexp "<span class="quote">Display kill ring entries matching</span>")))
  (assert (eq major-mode 'browse-kill-ring-mode))
  (browse-kill-ring-setup (current-buffer)
			  browse-kill-ring-original-window
			  regexp)
  (browse-kill-ring-resize-window))

(defun browse-kill-ring-fontify-on-property (prop face beg end)
  (save-excursion
    (goto-char beg)
    (let ((prop-end nil))
      (while
	  (setq prop-end
		(let ((prop-beg (or (and (get-text-property (point) prop) (point))
				    (next-single-property-change (point) prop nil end))))
		  (when (and prop-beg (not (= prop-beg end)))
		    (let ((prop-end (next-single-property-change prop-beg prop nil end)))
		      (when (and prop-end (not (= prop-end end)))
			(put-text-property prop-beg prop-end 'face face)
			prop-end)))))
	(goto-char prop-end)))))

(defun browse-kill-ring-fontify-region (beg end &optional verbose)
  (when verbose (message "<span class="quote">Fontifying...</span>"))
  (let ((buffer-read-only nil))
    (browse-kill-ring-fontify-on-property 'browse-kill-ring-extra 'bold beg end)
    (browse-kill-ring-fontify-on-property 'browse-kill-ring-separator
					  browse-kill-ring-separator-face beg end))
  (when verbose (message "<span class="quote">Fontifying...done</span>")))

(defun browse-kill-ring-update ()
  "<span class="quote">Update the buffer to reflect outside changes to `kill-ring'.</span>"
  (interactive)
  (assert (eq major-mode 'browse-kill-ring-mode))
  (browse-kill-ring-setup (current-buffer)
			  browse-kill-ring-original-window)
  (browse-kill-ring-resize-window))

(defun browse-kill-ring-setup (buf window &optional regexp window-config)
  (with-current-buffer buf
    (unwind-protect
	(progn
	  (browse-kill-ring-mode)
	  (setq buffer-read-only nil)
	  (when (eq browse-kill-ring-display-style
		    'one-line)
	    (setq truncate-lines t))
	  (let ((inhibit-read-only t))
	    (erase-buffer))
	  (setq browse-kill-ring-original-window window
		browse-kill-ring-original-window-config
		(or window-config
		    (current-window-configuration)))
	  (let ((browse-kill-ring-maximum-display-length
		 (if (and browse-kill-ring-maximum-display-length
			  (&lt;= browse-kill-ring-maximum-display-length 3))
		     4
		   browse-kill-ring-maximum-display-length))
		(items (mapcar
			(if browse-kill-ring-depropertize
			    #'browse-kill-ring-depropertize-string
			  #'copy-sequence)
			kill-ring)))
	    (when (not browse-kill-ring-display-duplicates)
	      <span class="linecomment">;; I'm not going to rewrite `delete-duplicates'.  If</span>
	      <span class="linecomment">;; someone really wants to rewrite it here, send me a</span>
	      <span class="linecomment">;; patch.</span>
	      (require 'cl)
	      (setq items (delete-duplicates items :test #'equal)))
	    (when (stringp regexp)
	      (setq items (delq nil
				(mapcar
				 #'(lambda (item)
				     (when (string-match regexp item)
				       item))
				 items))))
	    (funcall (or (cdr (assq browse-kill-ring-display-style
				    browse-kill-ring-display-styles))
			 (error "<span class="quote">Invalid `browse-kill-ring-display-style': %s</span>"
				browse-kill-ring-display-style))
		     items)
<span class="linecomment">;; Code from Michael Slass &lt;mikesl@wrq.com&gt;</span>
	    (message
	     (let ((entry (if (= 1 (length kill-ring)) "<span class="quote">entry</span>" "<span class="quote">entries</span>")))
	       (concat
		(if (and (not regexp)
			 browse-kill-ring-display-duplicates)
		    (format "<span class="quote">%s %s in the kill ring.</span>"
			    (length kill-ring) entry)
		  (format "<span class="quote">%s (of %s) %s in the kill ring shown.</span>"
			  (length items) (length kill-ring) entry))
		(substitute-command-keys
		 (concat "<span class="quote">    Type \\[browse-kill-ring-quit] to quit.  </span>"
			 "<span class="quote">\\[describe-mode] for help.</span>")))))
<span class="linecomment">;; End code from Michael Slass &lt;mikesl@wrq.com&gt;</span>
	    (set-buffer-modified-p nil)
	    (goto-char (point-min))
	    (browse-kill-ring-forward 0)
	    (when regexp
	      (setq mode-name (concat "<span class="quote">Kill Ring [</span>" regexp "<span class="quote">]</span>")))
	    (run-hooks 'browse-kill-ring-hook)
	    <span class="linecomment">;; I will be very glad when I can get rid of this gross</span>
	    <span class="linecomment">;; hack, which solely exists for XEmacs users.</span>
	    (when (and (featurep 'xemacs)
		       font-lock-mode)
	      (browse-kill-ring-fontify-region (point-min) (point-max)))))
      (progn
	(setq buffer-read-only t)))))

<span class="linecomment">;;;###autoload</span>
(defun browse-kill-ring ()
  "<span class="quote">Display items in the `kill-ring' in another buffer.</span>"
  (interactive)
  (if (eq major-mode 'browse-kill-ring-mode) 
      (message "<span class="quote">Already viewing the kill ring</span>")
    (let ((orig-buf (current-buffer))
	  (buf (get-buffer-create "<span class="quote">*Kill Ring*</span>")))
      (browse-kill-ring-setup buf (selected-window))
      (pop-to-buffer buf)
      (browse-kill-ring-resize-window)
      nil)))

(provide 'browse-kill-ring)

<span class="linecomment">;;; browse-kill-ring.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=browse-kill-ring.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=browse-kill-ring.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=browse-kill-ring.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=browse-kill-ring.el">Administration</a></span><span class="time"><br /> Last edited 2009-01-20 05:01 UTC by <a class="author" title="from i577A0446.versanet.de" href="http://www.emacswiki.org/emacs/Benjamin_Andresen">Benjamin Andresen</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=browse-kill-ring.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
