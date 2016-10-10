BlockUIAlertView
================

带block的uialertview

###Step 1

```obj-c
BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithTitle:nil message:@"是否清空缓存" cancelButtonTitle:@"取消" clickButton:^(NSInteger index) {
            if (index==1) {
                [[[SDWebImageManager sharedManager] imageCache] clearDisk];
                [self.tableView reloadData];
            }
        } otherButtonTitles:@"确定"];
        [alert show];
```

###Done!
