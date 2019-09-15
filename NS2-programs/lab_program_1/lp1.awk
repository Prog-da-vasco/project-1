BEGIN{
	count=0;
}
{
	if($1 == "d")
		count++
}
END{
	printf("Number of dropped packets is:%d\n",count);
}
