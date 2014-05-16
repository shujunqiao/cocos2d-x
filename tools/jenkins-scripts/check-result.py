#!/usr/bin/python
import os
import urllib2
import sys

error_keyword = '{"ios_mac":"error:", "win32_win7":"error lnk"}'
if os.environ.has_key('ERROR_KEYWORD'):
	error_keyword = os.environ['ERROR_KEYWORD']
error_keyword = eval(error_keyword)
print 'error_keyword:', error_keyword

build_number = 1
if os.environ.has_key('BUILD_NUMBER'):
	build_number = os.environ['BUILD_NUMBER']
print 'build_number:', build_number

error_output_num = 10
if os.environ.has_key('ERROR_OUTPUT_NUM'):
	error_output_num = int(os.environ['ERROR_OUTPUT_NUM'])
print 'error_output_num:', error_output_num

url_pre = ''
if os.environ.has_key('BUILD_URL'):
	url_pre = os.environ['BUILD_URL'] + 'node='
print 'url_pre:', url_pre

def main():
	print 'in main:'
	for key in error_keyword:
		url = url_pre + str(key) + '/consoleFull'
		print 'url', url
		page = urllib2.urlopen(url, timeout=10)
		data = page.read()
		lines = data.split('\n')
		errs = []
		keyword = error_keyword[key]
		print 'keyword:', keyword, type(keyword)
		for item in lines:
			# print '\nitem:', item, '\n'
			if item.count( keyword ):
				errs.append(item)
		if len(errs) and errs[0].count('error: branch \'pull'):
			del errs[0]
		print 'result of '+str(key)+':'
		print 'error count:', len(errs)
		for error in errs[0:error_output_num]:
			print str(error)
		print ''
	print 'check result end'

# -------------- main --------------
if __name__ == '__main__':
    sys_ret = 0
    try:    
        sys_ret = main()
    except:
        traceback.print_exc()
        sys_ret = 1
    finally:
        sys.exit(sys_ret)
