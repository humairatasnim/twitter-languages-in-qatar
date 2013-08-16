import sys;

dict_lang = {};
for line in sys.stdin:
	line = line.strip();
	line_split = line.split("\t");
	key = line_split[3]+"\t"+line_split[4];#+"\t"+line_split[5];
	lang = line_split[5];
	if(dict_lang.has_key(key)):
		tmp = dict_lang[key];
		tmp[lang] += 1;
		dict_lang[key] = tmp;
	else:
		tmp = {"en":0,"ar":0,"tl":0,"es":0,"fr":0,"ur":0,"other":0,"ne":0,"hi":0,"ml":0,"bn":0};
		tmp[lang] += 1;
		dict_lang[key] = tmp;

for keys in dict_lang.keys():
	print keys + "\t" + str(dict_lang[keys]["en"]) + "\t" + str(dict_lang[keys]["ar"]) + "\t" + str(dict_lang[keys]["tl"]) + "\t" + str(dict_lang[keys]["es"]) + "\t" + str(dict_lang[keys]["fr"]) + "\t" + str(dict_lang[keys]["ur"]) + "\t" + str(dict_lang[keys]["other"]) + "\t" + str(dict_lang[keys]["ne"]) + "\t" + str(dict_lang[keys]["hi"]) + "\t" + str(dict_lang[keys]["ml"]) + "\t" + str(dict_lang[keys]["bn"]);
