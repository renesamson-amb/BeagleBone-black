#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

static int __init my_init(void)
{
	printk(KERN_INFO "Hello, DARK WORLD!");
	return 0;
}

static void __exit my_exit(void)
{
	printk(KERN_INFO "Goodbye cruel world\n");
}

module_init(my_init);
module_exit(my_exit);

