#
# defines the base classes that all servers share
#

class briar-patch-base {

  package { ["git", "mercurial", "python-setuptools"]:
    ensure => "latest";
  }

  exec { "clone-redis-py":
    command => "/usr/bin/git clone https://github.com/andymccurdy/redis-py",
    cwd => "/tmp/",
    require => Package["git"],
    creates => "/tmp/redis-py";
  }

  exec { "install-redis-py":
     command => "/usr/bin/python setup.py install",
     require => [Exec["clone-redis-py"],
                 Package["python-setuptools"]],
     cwd => "/tmp/redis-py";
  }

  exec { "clone-mozillapulse":
    command => "/usr/bin/hg clone http://hg.mozilla.org/users/clegnitto_mozilla.com/mozillapulse",
    cwd => "/tmp/",
    require => Package["mercurial"],
    creates => "/tmp/mozillapulse";
  }

  exec { "install-mozilla-pulse":
     command => "/usr/bin/python setup.py install",
     require => [Exec["clone-mozillapulse"],
                 Package["python-setuptools"]],
     cwd => "/tmp/mozillapulse",
     creates => "/tmp/mozillapulse";
  }

  exec { ["/usr/bin/easy_install django",
          "/usr/bin/easy_install django-tagging",
          "/usr/bin/easy_install whisper"]:
     cwd => "/tmp";
  }

  #group { "puppet":
  #  ensure => "present",
  #}

}
