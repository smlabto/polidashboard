/*
Description:
    We receive locational data from facebook as a state name (string), but when 
    Generating map visualizations using topography json files on the frontend
    We receive them as numerical codes, this file acts as a key-value pair to convert
    The respective state names to their numerical codes

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
    ["Asturias", "03"],
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
    'br': br,
    'es': es,
    'dk': dk,
    // ^^^ add defined maps here
}

module.exports = maps;