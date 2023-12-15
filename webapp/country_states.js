/*
Description:
    We receive locational data from facebook as a state name (string), but when 
    Generating map visualizations using topography json files on the frontend
    We receive them as numerical codes, this file acts as a key-value pair to convert
    The respective state names to their numerical codes

    If you want to add them yourself:
    The first value should be the exact string that Facebooks API uses, and the second should be the id that the TopoJSON uses.

    All codes refer to id's found in TopoJsons gathered from https://code.highcharts.com/mapdata/

    For Spain, the map is taken from unpkg (https://unpkg.com/es-atlas@0.5.0/es/autonomous_regions.json)
    As it supports autonomous regions, which is what facebook provides us with
*/

const us = new Map([
    ["Unknown", "N/A"],
    ["Alabama", "01"],
    ["Alaska", "02"],
    ["Arizona", "04"],
    ["Arkansas", "05"],
    ["California", "06"],
    ["Colorado", "08"],
    ["Connecticut", "09"],
    ["Delaware", "10"],
    ["Washington, District of Columbia", "11"],
    ["Florida", "12"],
    ["Georgia", "13"],
    ["Hawaii", "15"],
    ["Idaho", "16"],
    ["Illinois", "17"],
    ["Indiana", "18"],
    ["Iowa", "19"],
    ["Kansas", "20"],
    ["Kentucky", "21"],
    ["Louisiana", "22"],
    ["Maine", "23"],
    ["Maryland", "24"],
    ["Massachusetts", "25"],
    ["Michigan", "26"],
    ["Minnesota", "27"],
    ["Mississippi", "28"],
    ["Missouri", "29"],
    ["Montana", "30"],
    ["Nebraska", "31"],
    ["Nevada", "32"],
    ["New Hampshire", "33"],
    ["New Jersey", "34"],
    ["New Mexico", "35"],
    ["New York", "36"],
    ["North Carolina", "37"],
    ["North Dakota", "38"],
    ["Ohio", "39"],
    ["Oklahoma", "40"],
    ["Oregon", "41"],
    ["Pennsylvania", "42"],
    ["Rhode Island", "44"],
    ["South Carolina", "45"],
    ["South Dakota", "46"],
    ["Tennessee", "47"],
    ["Texas", "48"],
    ["Utah", "49"],
    ["Vermont", "50"],
    ["Virginia", "51"],
    ["Washington", "53"],
    ["West Virginia", "54"],
    ["Wisconsin", "55"],
    ["Wyoming", "56"]
]);

const br = new Map([
    ["Unknown", "N/A"],
    ["Acre (state)", "BR.AC"], 
    ["Alagoas", "BR.AL"], 
    ["Amapá", "BR.AP"], 
    ["Amazonas", "BR.AM"],
    ["Bahia", "BR.BA"], 
    ["Ceará", "BR.CE"], 
    ["Federal District", "BR.DF"], 
    ["Espírito Santo", "BR.ES"], 
    ["Goiás", "BR.GO"], 
    ["Maranhão", "BR.MA"], 
    ["Mato Grosso", "BR.MT"], 
    ["Mato Grosso do Sul", "BR.MS"], 
    ["Minas Gerais", "BR.MG"], 
    ["Pará", "BR.PA"], 
    ["Paraíba", "BR.PB"], 
    ["Paraná", "BR.PR"], 
    ["Pernambuco", "BR.PE"], 
    ["Piauí", "BR.PI"], 
    ["Rio de Janeiro (state)", "BR.RJ"], 
    ["Rio Grande do Norte", "BR.RN"], 
    ["Rio Grande do Sul", "BR.RS"], 
    ["Rondônia", "BR.RO"], 
    ["Roraima", "BR.RR"], 
    ["Santa Catarina", "BR.SC"], 
    ["São Paulo (state)", "BR.SP"], 
    ["Sergipe", "BR.SE"], 
    ["Tocantins", "BR.TO"], 
]);

const ca = new Map([
    ["Unknown", "N/A"],
    ["Manitoba", "CA.MB"],
    ["Saskatchewan", "CA.SK"],
    ["Alberta", "CA.AB"],
    ["British Columbia", "CA.BC"],
    ["Nunavut", "CA.NU"],
    ["Northwest Territories", "CA.NT"],
    ["Newfoundland and Labrador", "CA.NL"],
    ["Nova Scotia", "CA.NS"],
    ["Ontario", "CA.ON"],
    ["Quebec", "CA.QC"],
    ["New Brunswick", "CA.NB"],
    ["Yukon", "CA.YT"],
    ["Prince Edward Island", "CA.PE"],
]);

const de = new Map([
    ["Unknown", "N/A"],
    ["Baden-Württemberg", "DE.BW"],
    ["Bayern", "DE.BY"],
    ["Berlin", "DE.BE"],
    ["Brandenburg", "DE.BB"],
    ["Bremen", "DE.HB"],
    ["Hamburg", "DE.HH"],
    ["Hessen", "DE.HE"],
    ["Mecklenburg-Vorpommern", "DE.MV"],
    ["Niedersachsen", "DE.NI"],
    ["Nordrhein-Westfalen", "DE.NW"],
    ["Rheinland-Pfalz", "DE.RP"],
    ["Saarland", "DE.SL"],
    ["Sachsen", "DE.SN"],
    ["Saxony-Anhalt", "DE.ST"],
    ["Schleswig-Holstein", "DE.SH"],
    ["Thüringen", "DE.TH"]
]);

const fr = new Map([
    ["Unknown", "N/A"],
    ["Poitou-Charentes", "FR.T"],
    ["Corse", "FR.H"],
    ["Bretagne", "FR.E"],
    ["Pays de la Loire", "FR.R"],
    ["Provence-Alpes-Côte d'Azur", "FR.U"],
    ["Midi-Pyrénées", "FR.N"],
    ["Basse-Normandie", "FR.P"],
    ["Nord-Pas-de-Calais", "FR.O"],
    ["Rhône-Alpes", "FR.V"],
    ["Picardie", "FR.S"],
    ["Champagne-Ardenne", "FR.G"],
    ["Languedoc-Roussillon", "FR.K"],
    ["Alsace", "FR.A"],
    ["Auvergne", "FR.C"],
    ["Centre", "FR.F"],
    ["Limousin", "FR.L"],
    ["Bourgogne", "FR.D"],
    ["Aquitaine", "FR.B"],
    ["Franche-Comté", "FR.I"],
    ["Haute-Normandie", "FR.Q"],
    ["Île-de-France", "FR.J"],
    ["Lorraine", "FR.M"],
    ["Réunion", "FR.RE"],
    ["Mayotte", "FR.YT"],
    ["French Guiana", "FR.GF"],
    ["Martinique", "FR.MQ"],
    ["Guadeloupe", "FR.GP"],
]);

const au = new Map([
    ["Unknown", "N/A"],
    ["New South Wales", "AU.NSW"], 
    ["Victoria", "AU.VIC"], 
    ["Queensland", "AU.QLD"], 
    ["South Australia", "AU.SA"], 
    ["Western Australia", "AU.WA"],
    ["Tasmania", "AU.TAS"],
    ["Northern Territory", "AU.NT"], 
    ["Australian Capital Territory", "AU.ACT"],
    ["Jervis Bay Territory", "AU.JB"],
]);

const es = new Map([
    ["Unknown", "N/A"],
    ["Andalusia", "01"], 
    ["Aragón", "02"],
    ["Principality of Asturias", "03"],
    ["Balearic Islands", "04"],
    ["Islas Canarias", "05"],
    ["Cantabria", "06"],
    ["Castilla y Leon", "07"], 
    ["Castilla-La Mancha", "08"],
    ["Cataluña", "09"],
    ["Comunidad Valenciana", "10"],
    ["Extremadura", "11"],
    ["Galicia", "12"],
    ["Comunidad de Madrid", "13"],
    ["Region of Murcia", "14"],
    ["Navarra", "15"],
    ["País Vasco", "16"],
    ["La Rioja", "17"],
    ["Ceuta", "18"],
    ["Melilla", "19"],
]);

const dk = new Map([
    ["Unknown", "N/A"],
    ["Capital Region of Denmark", "DK.6325"], 
    ["Central Denmark Region", "DK.6326"],
    ["North Denmark Region", "DK.3568"],
    ["Zealand Region", "DK.3563"],
    ["Region of Southern Denmark", "DK.3564"],
]);

const id = new Map([ 
    ["Unknown", "N/A"],
    ["Aceh", "ID.AC"], // #1 (In GeometryCollection object)
    ["Bali", "ID.BA"], // #7
    ["Bangka–Belitung Islands", "ID.BB"], // #6
    ["Banten", "ID.BT"], // #4
    ["Bengkulu", "ID.BE"], // #3
    ["Central Java", "ID.JT"], // #2
    ["Central Kalimantan", "ID.KT"], // #34
    ["Central Sulawesi", "ID.ST"], // #23
    ["East Java", "ID.JI"], // #8
    ["East Kalimantan", "ID.KI"], // #26
    ["East Nusa Tenggara", "ID.NT"], // #10
    ["Gorontalo", "ID.GO"], // #30
    ["Jakarta", "ID.JK"], // #28
    ["Jambi", "ID.JA"], // #33
    ["Lampung", "ID.1024"], // #33
    ["Maluku", "ID.MA"], // #20
    ["North Kalimantan", "ID.KU"], // #17
    ["North Maluku", "ID.LA"], // #18
    ["North Sulawesi", "ID.SW"], // #16
    ["North Sumatra", "ID.SU"], // #14
    ["Papua (province)", "ID.PA"], // #24
    ["Riau Islands Province", "ID.KR"], // #12
    ["Riau", "ID.RI"], // #15
    ["South Kalimantan", "ID.KS"], // #9
    ["South Sulawesi", "ID.SE"], // #11
    ["South Sumatra", "ID.SL"], // #31
    ["Southeast Sulawesi", "ID.SG"], // #22
    ["Special Region of Yogyakarta", "ID.YO"], // #31
    ["West Java", "ID.JR"], // #25
    ["West Kalimantan", "ID.KB"], // #5
    ["West Nusa Tenggara", "ID.NB"], // #21
    ["West Papua", "ID.IB"], // #13
    ["West Sulawesi", "ID.SR"], // #32
    ["West Sumatra", "ID.SB"], // #19
]);

const ind = new Map([
    ["Unknown", "N/A"],
    ["Puducherry", "IN.PY"],
    ["Lakshadweep", "IN.LD"],
    ["Andaman and Nicobar Islands", "IN.AN"],
    ["West Bengal", "IN.WB"],
    ["Odisha", "IN.OR"],
    ["Bihar", "IN.BR"], 
    ["Sikkim", "IN.SK"],
    ["Chhattisgarh", "IN.CT"],
    ["Tamil Nadu", "IN.TN"],
    ["Madhya Pradesh", "IN.MP"],
    ["Gujarat", "IN.2984"],
    ["Goa", "IN.GA"],
    ["Nagaland", "IN.NL"],
    ["Manipur", "IN.MN"],
    ["Arunachal Pradesh", "IN.AR"],
    ["Mizoram", "IN.MZ"],
    ["Tripura", "IN.TR"],
    ["Delhi", "IN.DL"],
    ["Haryana", "IN.HR"],
    ["Chandigarh", "IN.CH"],
    ["Himachal Pradesh", "IN.HP"],
    ["Jammu and Kashmir", "IN.JK"],
    ["Kerala", "IN.KL"],
    ["Karnataka", "IN.KA"],
    ["Dadra and Nagar Haveli", "IN.DN"],
    ["Maharashtra", "IN.MH"],
    ["Assam", "IN.AS"],
    ["Andhra Pradesh", "IN.AP"],
    ["Meghalaya", "IN.ML"],
    ["Punjab region", "IN.PB"],
    ["Rajasthan", "IN.RJ"],
    ["Uttar Pradesh", "IN.UP"],
    ["Uttarakhand", "IN.UT"],
    ["Jharkhand", "IN.JH"],
]);

const it = new Map([
    ["Unknown", "N/A"],
    ["Piedmont", 1], // C
    ["Aosta Valley", 2],
    ["Lombardia", 3],
    ["Trentino-Alto Adige", 4], // C
    ["Veneto", 5],
    ["Friuli-Venezia Giulia", 6],
    ["Liguria", 7],
    ["Emilia-Romagna", 8],
    ["Tuscany", 9], // C
    ["Umbria", 10],
    ["Marche", 11],
    ["Lazio", 12],
    ["Abruzzo", 13],
    ["Molise", 14],
    ["Campania", 15],
    ["Puglia", 16],
    ["Basilicata", 17],
    ["Calabria", 18],
    ["Sicilia", 19],
    ["Sardinia", 20], // C
]);

const ph = new Map([ 
    ["Unknown", "N/A"],
    ["Davao Region", 11],
    ["Central Visayas", 7],
    ["Eastern Visayas", 8],
    ["Western Visayas", 6],
    ["Bicol Region", 5],
    ["Calabarzon", 4],
    ["Autonomous Region in Muslim Mindanao", 19],
    ["Central Luzon", 3],
    ["Mimaropa", 17],
    ["Cagayan Valley", 2],
    ["Soccsksargen", 12],
    ["Northern Mindanao", 10],
    ["Ilocos Region", 1],
    ["Cordillera Administrative Region", 14],
    ["Metro Manila", 13],
    ["Zamboanga Peninsula", 9],
    ["Caraga", 16],
]);

const pl = new Map([ 
    ["Unknown", "N/A"],
    ["Łódź Voivodeship", 'PL.LD'],
    ["Masovian Voivodeship", 'PL.MZ'],
    ["Świętokrzyskie Voivodeship", 'PL.SK'],
    ["Podlaskie Voivodeship", 'PL.PD'],
    ["Lublin Voivodeship", 'PL.LU'],
    ["Podkarpackie Voivodeship", 'PL.PK'],
    ["Opole Voivodeship", 'PL.OP'],
    ["Lesser Poland Voivodeship", 'PL.MA'],
    ["Warmian-Masurian Voivodeship", 'PL.WN'],
    ["Pomeranian Voivodeship", 'PL.PM'],
    ["Lower Silesian Voivodeship", 'PL.DS'],
    ["West Pomeranian Voivodeship", 'PL.ZP'],
    ["Lubusz Voivodeship", 'PL.LB'],
    ["Greater Poland Voivodeship", 'PL.WP'],
    ["Kuyavian-Pomeranian Voivodeship", 'PL.KP'],
    ["Silesian Voivodeship", 'PL.SL'],
]);

const gb = new Map([
    ["Unknown", "N/A"],
    ["England", "GB.ENG"],
    ["Scotland", "GB.SCT"],
    ["Wales", "GB.WLS"],
    ["Northern Ireland", "GB.NIR"]
]);

// ^^^ Add more map key-value pairs above here, name maps as their 2 character country code

const maps = {
    'us': us,
    'ca': ca,
    'de': de,
    'au': au,
    'gb': gb,
    'fr': fr,
    'id': id,
    'in': ind,
    'it': it,
    'ph': ph,
    'pl': pl,
    'br': br,
    'es': es,
    'dk': dk,
    // ^^^ add defined maps here
}

module.exports = maps;