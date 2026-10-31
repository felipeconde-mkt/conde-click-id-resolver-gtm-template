const getUrl = require('getUrl');
const getReferrerUrl = require('getReferrerUrl');
const localStorage = require('localStorage');
const JSON = require('JSON');
const makeString = require('makeString');
const getTimestampMillis = require('getTimestampMillis');
const decodeUriComponent = require('decodeUriComponent');
const toBase64 = require('toBase64');

const GOOGLE_STORAGE_KEY = 'google_session_attributes';

const trim = value => {
  if (value === undefined || value === null) return '';
  let text = makeString(value);
  while (text.length && (text[0] === ' ' || text[0] === '\t' || text[0] === '\n')) text = text.slice(1);
  while (text.length && (text[text.length - 1] === ' ' || text[text.length - 1] === '\t' || text[text.length - 1] === '\n')) text = text.slice(0, text.length - 1);
  return text;
};

const safeDecode = value => {
  const decoded = decodeUriComponent(makeString(value).split('+').join(' '));
  return decoded === undefined ? makeString(value) : decoded;
};

const parseQuery = queryText => {
  const result = {};
  if (!queryText) return result;
  const pairs = makeString(queryText).split('&');
  let index = 0;
  while (index < pairs.length) {
    const pair = pairs[index];
    const separator = pair.indexOf('=');
    const rawKey = separator === -1 ? pair : pair.slice(0, separator);
    const rawValue = separator === -1 ? '' : pair.slice(separator + 1);
    const key = safeDecode(rawKey);
    const value = trim(safeDecode(rawValue));
    if (key && value && result[key] === undefined) result[key] = value;
    index++;
  }
  return result;
};

const reverseText = text => {
  const value = trim(text);
  let reversed = '';
  let index = value.length - 1;
  while (index >= 0) {
    reversed += value[index];
    index--;
  }
  return reversed;
};

const query = parseQuery(getUrl('query'));
const result = {};

const resolve = (outputName, names) => {
  let index = 0;
  while (index < names.length) {
    const value = trim(query[names[index]]);
    if (value) {
      result[outputName] = value;
      return;
    }
    index++;
  }
};

// O primeiro nome é o parâmetro oficial. O segundo é sempre o nome oficial
// com todos os caracteres em ordem inversa, sem prefixos ou sufixos extras.
const mappings = [
  ['gclid', ['gclid', 'dilcg']],
  ['dclid', ['dclid', 'dilcd']],
  ['wbraid', ['wbraid', 'diarbw']],
  ['gbraid', ['gbraid', 'diarbg']],
  ['fbclid', ['fbclid', 'dilcbf']],
  ['ttclid', ['ttclid', 'dilctt']],
  ['msclkid', ['msclkid', 'diklcsm']],
  ['epik', ['epik', 'kipe']],
  ['li_fat_id', ['li_fat_id', 'di_taf_il']],
  ['twclid', ['twclid', 'dilcwt']],
  ['tblci', ['tblci', 'iclbt']],
  ['obclid', ['obclid', 'dilcbo']],
  ['sc_click_id', ['ScCid', 'diCcS']],
  ['rdt_cid', ['rdt_cid', 'dic_tdr']],
  ['yclid', ['yclid', 'dilcy']],
  ['irclickid', ['irclickid', 'dikcilcri']],
  ['aff_click_id', ['aff_click_id', 'di_kcilc_ffa']],
  ['clickid', ['clickid', 'dikcilc']],
  ['oppref', ['oppref', 'ferppo']],
  ['rc_uuid', ['rc_uuid', 'diuu_cr']],
  ['newsbreak_cid', ['newsbreak_cid', 'dic_kaerbswen']],
  ['mgid_click_id', ['mgid_click_id', 'di_kcilc_digm']]
];

let mappingIndex = 0;
while (mappingIndex < mappings.length) {
  resolve(mappings[mappingIndex][0], mappings[mappingIndex][1]);
  mappingIndex++;
}

const customMappings = data.customMappings || [];
let customIndex = 0;
while (customIndex < customMappings.length) {
  const row = customMappings[customIndex] || {};
  const parameter = trim(row.parameter);
  if (parameter) resolve(parameter, [parameter, reverseText(parameter)]);
  customIndex++;
}

if (data.includeSessionAttributes) {
  const googleAttributes = {};
  let hasGoogleParams = result.gclid !== undefined || result.gbraid !== undefined || result.wbraid !== undefined || result.dclid !== undefined;
  for (const queryKey in query) {
    if (queryKey.indexOf('gad_') === 0) {
      googleAttributes[queryKey] = query[queryKey];
      hasGoogleParams = true;
    }
  }
  let encoded;
  if (hasGoogleParams) {
    googleAttributes.session_start_time_usec = makeString(getTimestampMillis() * 1000);
    googleAttributes.landing_page_url = getUrl();
    googleAttributes.landing_page_referrer = getReferrerUrl();
    encoded = toBase64(JSON.stringify(googleAttributes)).split('+').join('-').split('/').join('_');
    while (encoded.length && encoded[encoded.length - 1] === '=') encoded = encoded.slice(0, encoded.length - 1);
    localStorage.setItem(GOOGLE_STORAGE_KEY, encoded);
  } else {
    encoded = localStorage.getItem(GOOGLE_STORAGE_KEY);
  }
  if (encoded) result.session_attributes_encoded = encoded;
}

if (data.outputMode === 'single') return result[data.singleKey];
for (const resultKey in result) return result;
return undefined;
