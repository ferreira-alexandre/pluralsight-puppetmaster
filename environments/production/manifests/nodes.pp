node 'wiki' {

  hiera_include('classes')

}


node 'wikitest' {

  hiera_include('classes')

}

node 'winadmin' {

  hiera_include('classes')

}

class linux {

  $admintools = ['git', 'nano', 'screen', 'less']

  package { $admintools:
    ensure => 'installed'
  }

  $ntpservice = $osfamily ? {
    'redhat' => 'ntpd',
    'debian' => 'ntp',
    'default' => 'ntp',
  }

  file{ '/info.txt':
    ensure  => 'present',
    content => inline_template("Created by Puppey at <%= Time.now %>\n"),
  }

  package{ 'ntp' :
    ensure => 'installed',
  }

  service{ $ntpservice:
    ensure => 'running',
    enable => true
  }

}
