___TERMS_OF_SERVICE___
By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos

___INFO___
{
  "type": "MACRO",
  "id": "conde_click_id_resolver_web",
  "version": 1,
  "securityGroups": [],
  "displayName": "👑 Click ID Resolver - by Conde MKTech",
  "brand": {
    "id": "conde_mktech",
    "displayName": "Conde MKTech",
    "thumbnail": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNTYiIGhlaWdodD0iMjU2IiB2aWV3Qm94PSIwIDAgMjU2IDI1NiIgcm9sZT0iaW1nIiBhcmlhLWxhYmVsbGVkYnk9InRpdGxlIGRlc2MiPgogIDx0aXRsZSBpZD0idGl0bGUiPkNvcm9hIENvbmRlIE1LVGVjaDwvdGl0bGU+CiAgPGRlc2MgaWQ9ImRlc2MiPkNvcm9hIGRvdXJhZGEgbWluaW1hbGlzdGEgdXNhZGEgbmEgaWRlbnRpZGFkZSB2aXN1YWwgZGEgQ29uZGUgTUtUZWNoLjwvZGVzYz4KICA8cGF0aCBmaWxsPSIjRkZDNjI5IiBkPSJNMjYgNzEgNzYgMTE1IDEyOCAzMiAxODAgMTE1IDIzMCA3MSAyMDkgMjE0IDQ3IDIxNFoiLz4KPC9zdmc+Cg=="
  },
  "description": "Resolve identificadores de clique de múltiplas plataformas em uma única variável, com aliases invertidos anti-ITP, persistência em localStorage e Google Session Attributes.",
  "categories": [
    "ADVERTISING",
    "ANALYTICS"
  ],
  "containerContexts": [
    "WEB"
  ]
}

___TEMPLATE_PARAMETERS___
[
  {
    "type": "GROUP",
    "name": "outputGroup",
    "displayName": "Saída",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "SELECT",
        "name": "outputMode",
        "displayName": "Formato de saída",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "all",
            "displayValue": "Objeto com todos os identificadores"
          },
          {
            "value": "single",
            "displayValue": "Somente um identificador"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "all"
      },
      {
        "type": "SELECT",
        "name": "singleKey",
        "displayName": "Identificador no modo único",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "gclid",
            "displayValue": "Google Ads — gclid"
          },
          {
            "value": "dclid",
            "displayValue": "Google Campaign Manager / DV360 — dclid"
          },
          {
            "value": "wbraid",
            "displayValue": "Google Ads — wbraid"
          },
          {
            "value": "gbraid",
            "displayValue": "Google Ads — gbraid"
          },
          {
            "value": "fbclid",
            "displayValue": "Meta — fbclid"
          },
          {
            "value": "ttclid",
            "displayValue": "TikTok — ttclid"
          },
          {
            "value": "msclkid",
            "displayValue": "Microsoft Ads — msclkid"
          },
          {
            "value": "epik",
            "displayValue": "Pinterest — epik"
          },
          {
            "value": "li_fat_id",
            "displayValue": "LinkedIn — li_fat_id"
          },
          {
            "value": "twclid",
            "displayValue": "X / Twitter — twclid"
          },
          {
            "value": "tblci",
            "displayValue": "Taboola — tblci"
          },
          {
            "value": "obclid",
            "displayValue": "Outbrain — obclid"
          },
          {
            "value": "sc_click_id",
            "displayValue": "Snapchat — ScCid"
          },
          {
            "value": "rdt_cid",
            "displayValue": "Reddit — rdt_cid"
          },
          {
            "value": "yclid",
            "displayValue": "Yandex — yclid"
          },
          {
            "value": "irclickid",
            "displayValue": "Impact — irclickid"
          },
          {
            "value": "oppref",
            "displayValue": "Origem personalizada — oppref"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "gclid",
        "enablingConditions": [
          {
            "paramName": "outputMode",
            "paramValue": "single",
            "type": "EQUALS"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "storageGroup",
    "displayName": "Persistência e Google Session Attributes",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "persistIds",
        "checkboxText": "Persistir identificadores no localStorage",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "A URL atual sempre tem prioridade. Na ausência do parâmetro, reutiliza o valor capturado anteriormente no mesmo domínio."
      },
      {
        "type": "CHECKBOX",
        "name": "includeSessionAttributes",
        "checkboxText": "Criar session_attributes_encoded para parâmetros gad_*",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Mantém a contingência do código original: captura gad_*, horário em micros, landing page e referrer, codifica em Base64 URL-safe e salva como google_session_attributes."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "customGroup",
    "displayName": "Identificadores personalizados",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "customMappings",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Nome na saída",
            "name": "outputName",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Parâmetro principal",
            "name": "primaryParam",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Fallbacks separados por vírgula",
            "name": "fallbackParams",
            "type": "TEXT"
          }
        ],
        "newRowButtonText": "Adicionar identificador",
        "help": "O primeiro parâmetro preenchido vence. Use esta tabela para redes, afiliados ou nomes invertidos próprios."
      }
    ]
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___
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

___WEB_PERMISSIONS___
[
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_local_storage",
        "versionId": "1"
      },
      "param": [
        {
          "key": "localStorageAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "localStorageKeys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "conde_click_identifiers"
              },
              {
                "type": 1,
                "string": "google_session_attributes"
              }
            ]
          }
        },
        {
          "key": "read",
          "value": {
            "type": 1,
            "boolean": true
          }
        },
        {
          "key": "write",
          "value": {
            "type": 1,
            "boolean": true
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]

___TESTS___
scenarios:
- name: Official parameter takes priority over inverted fallback
  code: runCode();
- name: Stored click identifiers are reused when URL has no identifiers
  code: runCode();
- name: Google gad parameters generate session_attributes_encoded
  code: runCode();
- name: Empty result returns undefined
  code: runCode();

___NOTES___
Created on 31/10/2026.
Homepage and support: https://conde.marketing
The official URL parameter always wins over inverted and legacy aliases.
Stored values are first-party localStorage values scoped to the current origin.
