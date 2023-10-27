/*
Description:
    We receive locational data from facebook as a state name (string), but when 
    Generating map visualizations using topography json files on the frontend
    We receive them as numerical codes, this file acts as a key-value pair to convert
    The respective state names to their numerical codes

    All codes refer to id's found in TopoJsons from https://code.highcharts.com/mapdata/
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

// const ca = new Map([
//     ["Unknown", "N/A"],
//     ["Manitoba", "CA-MB"],
//     ["Saskatchewan", "CA-SK"],
//     ["Alberta", "CA-AB"],
//     ["British Columbia", "CA-BC"],
//     ["Nunavut", "CA-NU"],
//     ["Northwest Territories", "CA-NT"],
//     ["Newfoundland and Labrador", "CA-NL"],
//     ["Nova Scotia", "CA-NS"],
//     ["Ontario", "CA-ON"],
//     ["Quebec", "CA-QC"],
//     ["New Brunswick", "CA-NB"],
//     ["Yukon", "CA-YT"],
//     ["Prince Edward Island", "CA-PE"],
// ]);

const br = new Map([
    ["Unknown", "N/A"],
    ["Acre (state)", "BR.AC"], // Checked
    ["Alagoas", "BR.AL"], // Checked
    ["Amapá", "BR.AP"], // Checked
    ["Amazonas", "BR.AM"],
    ["Bahia", "BR.BA"], // Checked
    ["Ceará", "BR.CE"], // Checked
    ["Federal District", "BR.DF"], // Checked
    ["Espírito Santo", "BR.ES"], // Checked
    ["Goiás", "BR.GO"], // Checked
    ["Maranhão", "BR.MA"], // Checked
    ["Mato Grosso", "BR.MT"], // Checked
    ["Mato Grosso do Sul", "BR.MS"], // Checked
    ["Minas Gerais", "BR.MG"], // Checked
    ["Pará", "BR.PA"], // Checked
    ["Paraíba", "BR.PB"], // Checked
    ["Paraná", "BR.PR"], // Checked
    ["Pernambuco", "BR.PE"], // Checked
    ["Piauí", "BR.PI"], // Checked
    ["Rio de Janeiro (state)", "BR.RJ"], // Checked
    ["Rio Grande do Norte", "BR.RN"], // Checked
    ["Rio Grande do Sul", "BR.RS"], // Checked
    ["Rondônia", "BR.RO"], // Checked
    ["Roraima", "BR.RR"], // Checked
    ["Santa Catarina", "BR.SC"], // Checked
    ["São Paulo (state)", "BR.SP"], // Checked
    ["Sergipe", "BR.SE"], // Checked
    ["Tocantins", "BR.TO"], // Checked
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

// const de = new Map([
//     ["Unknown", "N/A"],
//     ["Baden-Württemberg", "08"],
//     ["Bayern", "09"],
//     ["Berlin", "11"],
//     ["Brandenburg", "12"],
//     ["Bremen", "04"],
//     ["Hamburg", "02"],
//     ["Hessen", "06"],
//     ["Mecklenburg-Vorpommern", "13"],
//     ["Niedersachsen", "03"],
//     ["Nordrhein-Westfalen", "07"],
//     ["Rheinland-Pfalz", "10"],
//     ["Saarland", "12"],
//     ["Sachsen", "14"],
//     ["Sachsen-Anhalt", "15"],
//     ["Schleswig-Holstein", "01"],
//     ["Thüringen", "16"]
// ]);

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

// const au = new Map([
//     ["Unknown", "N/A"],
//     ["New South Wales", 0], // D
//     ["Victoria", 1], // D
//     ["Queensland", 2], // D
//     ["South Australia", 3], // D
//     ["Western Australia", 4],
//     ["Tasmania", 5],
//     ["Northern Territory", 6], //D 
//     ["Australian Capital Territory", 7],
//     ["Jervis Bay Territory", 8],
// ]);

const au = new Map([
    ["Unknown", "N/A"],
    ["New South Wales", "AU.NSW"], // D
    ["Victoria", "AU.VIC"], // D
    ["Queensland", "AU.QLD"], // D
    ["South Australia", "AU.SA"], // D
    ["Western Australia", "AU.WA"],
    ["Tasmania", "AU.TAS"],
    ["Northern Territory", "AU.NT"], //D 
    ["Australian Capital Territory", "AU.ACT"],
    ["Jervis Bay Territory", "AU.JB"],
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
    'br': br
    // ^^^ add defined maps here
}

module.exports = maps;