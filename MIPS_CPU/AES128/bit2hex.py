f = open("instruction_bin.txt")
f1=open("instruction_hex.txt","w")              # 返回一个文件对象 
line = f.readline()
i=0               # 调用文件的 readline()方法 
while line: 
	hex_num='{:08X}'.format(int(line,2))
	f1.write('RAM['+str(i)+']=32\'h'+hex_num+';\n')
	i+=1
	#print(line, end = '')　      # 在 Python 3 中使用 
	line = f.readline() 
f.close()  
f1.close()  

