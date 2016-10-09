# UI-14-UIDatePickView-SecondMenuBUG
解决二级联动Bug

- 当前选中的内蒙古省，只有12个城市，角标0~11，但是右边城市是北京，北京的城市大于12个城市，所以滚动的时候会出现越界。

- // 记录当前选中的省会
-  self.proIndex = [pickerView selectedRowInComponent:0];