const getUrl = require('getUrl');
const getReferrerUrl = require('getReferrerUrl');
const localStorage = require('localStorage');
const JSON = require('JSON');
const makeString = require('makeString');
const getTimestampMillis = require('getTimestampMillis');
const decodeUriComponent = require('decodeUriComponent');
const toBase64 = require('toBase64');

const STORAGE_KEY = 'conde_click_identifiers';
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

const splitNames = text => {
  const result = [];
  if (!text) return result;
  const values = makeString(text).split(',');
  let index = 0;
  while (index < values.length) {
    const value = trim(values[index]);
    if (value && result.indexOf(value) === -1) result.push(value);
    index++;
  }
  return result;
};

const readStored = key => {
  if (!data.persistIds) return {};
  const raw = localStorage.getItem(key);
  if (!raw) return {};
  const parsed = JSON.parse(raw);
  return parsed || {};
};

const query = parseQuery(getUrl('query'));
const stored = readStored(STORAGE_KEY);
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
  const previous = trim(stored[outputName]);
  if (previous) result[outputName] = previous;
};

// O primeiro nome é o parâmetro oficial. Os demais preservam as inversões
// e aliases legados usados como contingência contra bloqueios/remoções de ITP.
const mappings = [
  ['gclid', ['gclid', 'dilcg']],
  ['dclid', ['dclid', 'dilcd']],
  ['wbraid', ['wbraid']],
  ['gbraid', ['gbraid']],
  ['fbclid', ['fbclid', 'dilcbf']],
  ['ttclid', ['ttclid', 'dilctt']],
  ['msclkid', ['msclkid', 'diklcsm', 'dilcms']],
  ['epik', ['epik', 'kipe', 'dilckipe']],
  ['li_fat_id', ['li_fat_id', 'di_taf_il', 'dilcli']],
  ['twclid', ['twclid', 'dilcwt', 'dilctw']],
  ['tblci', ['tblci', 'tbclid', 'dilcbt', 'dilctb']],
  ['obclid', ['obclid', 'dilcbo', 'dilcob']],
  ['sc_click_id', ['ScCid', 'sccid', 'sc_click_id', 'scid', 'dics', 'dilcsc']],
  ['rdt_cid', ['rdt_cid', 'dic_tdr', 'dilcrdt']],
  ['yclid', ['yclid', 'dilcy']],
  ['irclickid', ['irclickid', 'dilcir']],
  ['aff_click_id', ['aff_click_id', 'dilcaff']],
  ['clickid', ['clickid', 'click_id', 'cid', 'dilc']],
  ['oppref', ['oppref', 'ferppo']],
  ['rc_uuid', ['rc_uuid']],
  ['newsbreak_cid', ['newsbreak_cid']],
  ['mgid_click_id', ['mgid_click_id', 'mgidclid']]
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
  const outputName = trim(row.outputName);
  const names = splitNames(row.primaryParam + ',' + (row.fallbackParams || ''));
  if (outputName && names.length) resolve(outputName, names);
  customIndex++;
}

if (data.persistIds) localStorage.setItem(STORAGE_KEY, JSON.stringify(result));

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
