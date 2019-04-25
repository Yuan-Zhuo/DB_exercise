# E-R model

---

## Entity

1. Bar：酒吧实体，主键是连锁店的名称和连锁店的序号
2. Drinker：顾客实体，主键是身份证号码，其余属性包括姓名、性别和年龄
3. Group：群体实体，主键是群体序号
4. Location：地址实体，主键是邮编，街道号以及楼栋号，其余属性包括州、郡、街道名以及楼栋名
5. Manufacturer：生产实体，主键是品牌名称和生产厂家名称（因生产地没有意义，故省去）
6. Beer：酒实体，弱实体集，除 Manufacturer 实体集主键外，还包括名称，类型，形态，规格

## Relationship

1. address:地址联系，酒吧与地址一对一
2. permanent residence：常住地，顾客与地址一对一
3. gather：结伴联系，2..n 个人构成 1..1 个群体
4. sales：出售联系：1..1 个酒吧对应 1..n 种酒，附加属性：价格
5. produce by：生产标志性联系，酒和生产一对一
6. often_bar、often_beer：常去的酒吧和常喝的联系，酒吧和酒分别与顾客多对一
7. favorite_bar、favorite_beer：最喜欢的酒吧和酒的联系，酒吧和酒分别与顾客一对一

## Generate PDM and SQL DDL SCRIPT

1. reference: [tutorial](https://blog.csdn.net/t_tss/article/details/21480845)

2. 表示弱实体集：联系中选择 Dependent
