module Geography
  STATES = [
    'WA',
    'ID',
    'MT',
    'ND',
    'MN',
    'MI',
    'NY',
    'VT',
    'NH',
    'ME',
  ]

  PROVINCES = [
    'BC',
    'AB',
    'SK',
    'MB',
    'ON',
    'QC',
    'NB',
  ]

  BORDERS = {

    #First use provinces as keys 
    'BC' => ['WA', 'ID', 'MT'],
    'AB' => ['MT'],
    'SK' => ['MT', 'ND'],
    'MB' => ['ND', 'MN'],
    'ON' => ['MN', 'MI', 'NY'],
    'QC' => ['NY', 'VT', 'NH', 'ME'],
    'NB' => ['ME'],

    #Then use states as keys
    'WA' => ['BC'],
    'ID' => ['BC'],
    'MT' => ['BC', 'AB', 'SK'],
    'ND' => ['SK', 'MB'],
    'MN' => ['MB', 'ON'],
    'MI' => ['ON'],
    'NY' => ['ON', 'QC'],
    'VT' => ['QC'],
    'NH' => ['QC'],
    'ME' => ['NB']
  }

end