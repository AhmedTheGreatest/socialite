// dayjs/plugin/advancedFormat@1.11.13 downloaded from https://ga.jspm.io/npm:dayjs@1.11.13/plugin/advancedFormat.js

var e=typeof globalThis!=="undefined"?globalThis:typeof self!=="undefined"?self:global;var r={};!function(e,t){r=t()}(0,(function(){return function(r,t){var a=t.prototype,s=a.format;a.format=function(r){var t=this||e,a=this.$locale();if(!this.isValid())return s.bind(this||e)(r);var n=this.$utils(),i=(r||"YYYY-MM-DDTHH:mm:ssZ").replace(/\[([^\]]+)]|Q|wo|ww|w|WW|W|zzz|z|gggg|GGGG|Do|X|x|k{1,2}|S/g,(function(e){switch(e){case"Q":return Math.ceil((t.$M+1)/3);case"Do":return a.ordinal(t.$D);case"gggg":return t.weekYear();case"GGGG":return t.isoWeekYear();case"wo":return a.ordinal(t.week(),"W");case"w":case"ww":return n.s(t.week(),"w"===e?1:2,"0");case"W":case"WW":return n.s(t.isoWeek(),"W"===e?1:2,"0");case"k":case"kk":return n.s(String(0===t.$H?24:t.$H),"k"===e?1:2,"0");case"X":return Math.floor(t.$d.getTime()/1e3);case"x":return t.$d.getTime();case"z":return"["+t.offsetName()+"]";case"zzz":return"["+t.offsetName("long")+"]";default:return e}}));return s.bind(this||e)(i)}}}));var t=r;export{t as default};

