# vagrant-emacs-mozc

Emacsの`mozc.el`、[ac-mozc](https://github.com/igjit/ac-mozc)の動作に必要な`mozc-server`、`mozc_emacs_helper`をVagrant上で動かすための設定です。

## 依存

- Vagrant
- VirtualBox

## インストール

git clone
```
$ git clone https://github.com/igjit/vagrant-emacs-mozc.git
$ cd vagrant-emacs-mozc/
```

VMを起動します。初回は時間がかかります。
```
$ vagrant up
```

`vagrant up`でboxファイルのダウンロードに失敗する場合は、boxファイルを手動でダウンロード、追加してみてください。
```
$ curl -O https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
$ vagrant box add trusty-server-cloudimg-amd64 ./trusty-server-cloudimg-amd64-vagrant-disk1.box
$ vagrant up
```

試しにVMにSSH接続します。接続が確認できたら`exit`で抜けます。
```
$ vagrant ssh
 :
vagrant@vagrant-ubuntu-trusty-64:~$ exit
```

mozcの動作確認
```
$ echo -e '(0 CreateSession)\n(1 SendKey 1 97)' | ./mozc_emacs_helper.sh
((mozc-emacs-helper . t)(version . "1.13.1651.102")(config . ((preedit-method . roman))))
((emacs-event-id . 0)(emacs-session-id . 1)(output . ()))
((emacs-event-id . 1)(emacs-session-id . 1)(output . ((id . "2112461956057362500")(mode . hiragana)(consumed . t)(preedit . ((cursor . 1)(segment ((annotation . underline)(value . "あ")(value-length . 1)(key . "あ")))))(candidates . ((size . 1)(candidate ((index . 0)(value . "あ")(annotation . ((description . "ひらがな")))(id . 0)))(position . 0)(category . suggestion)(display-type . main)(footer . ((label . "Tabキーで選択")))))(status . ((activated . t)(mode . hiragana)(comeback-mode . hiragana)))(all-candidate-words . ((candidates ((id . 0)(index . 0)(value . "あ")(annotation . ((description . "ひらがな")))))(category . suggestion))))))
```

[mozc.el](https://mozc.googlecode.com/svn/trunk/src/unix/emacs/mozc.el)をダウンロードして`load-path`通った場所に置いてください。

`init.el`の設定例。`/path/to`の部分は適切に設定してください。
```lisp
(require 'mozc)
(setq default-input-method "japanese-mozc")

(setq mozc-helper-program-name "/path/to/mozc_emacs_helper.sh")
(setq mozc-helper-process-timeout-sec 4)
```
