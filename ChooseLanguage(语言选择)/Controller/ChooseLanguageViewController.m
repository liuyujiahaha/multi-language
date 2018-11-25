//
//  ChooseLanguageViewController.m
//  PlayCarParadise
//
//  Created by liuyujia on 2018/4/10.
//  Copyright © 2018年 CarFun. All rights reserved.
//

#import "ChooseLanguageViewController.h"
#import "ChooseLanguageCell.h"
#import "PCTabBarViewController.h"
#import "NSBundle+Language.h"
#import "LanguageTool.h"

static NSString *appLanguage = @"appLanguage";
@interface ChooseLanguageViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *mainTab;         //tabview主视图
@property (nonatomic, strong) UIButton *comfirmBtn;         //确认按钮
@property (nonatomic, strong) NSArray *dataSource;          //数据源
///选中行  0简体中文  1ENGLISH
@property (nonatomic, assign) NSInteger selectedType;
@property (nonatomic, assign) NSInteger originType;         //原本的语言类型 若与selectedType相同则高亮确定按钮 否则不高亮
@end

@implementation ChooseLanguageViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleString = iStoreLocalizedString(@"语言选择");
    [self initData];
    [self initUI];
}

//默认选中状态要在tableview加载完成之后才可以设置
-(void)viewWillLayoutSubviews{
    [self initSelect];
}


#pragma mark - private methods
-(void)initData{
    self.dataSource = @[@"简体中文",@"English"];
}

-(void)initUI{
    [self.view addSubview:self.mainTab];
    [self.view addSubview:self.comfirmBtn];
    [self makeConstrain];
}

-(void)makeConstrain{
    [_mainTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(NavBarHeight);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [_comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20*layoutBy6());
        make.right.mas_equalTo(self.view).offset(-20*layoutBy6());
        make.height.mas_equalTo(40*layoutBy6());
        make.top.mas_equalTo(self.view).offset(NavBarHeight+200*layoutBy6());
    }];
}

//根据保存语言相应选中行
-(void)initSelect{
    NSString *languageStr = [LanguageTool getLanguageStr];
    NSIndexPath *indexPath;
    
    if ([languageStr containsString:kLanguageEnglish]) {
        //英语
        indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        self.originType = 1;
    }else if([languageStr containsString:kLanguageChinese]){
        //中文
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        self.originType = 0;
    }
    [self.mainTab selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    ChooseLanguageCell *cell = [self.mainTab cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:YES];

}


#pragma mark - changeLanguage method
//切换语言
- (void)changeLanguageTo:(NSString *)language {
    // 设置语言
    [NSBundle setLanguage:language];
    
    // 然后将设置好的语言存储好，下次进来直接加载
    UDSaveData(language, kChangeLanguage);
    
    if (self.block) {
        //设置一个切换语言的标识
        self.block();
    }
    //刷新app内容切换语言
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - reponse methods
-(void)comfirmAction{
    [ToolsObject showWithStatus:iStoreLocalizedString(@"正在设置语言")];
    if (self.selectedType == 0) {
        //简体中文
        [self changeLanguageTo:kLanguageChinese];
    }else if (self.selectedType == 1){
        //英文
        [self changeLanguageTo:kLanguageEnglish];
    }
}


#pragma mark - UITableViewDelegate and UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ChooseLanguageCell";
    ChooseLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ChooseLanguageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLbl.text = self.dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*layoutBy6();
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger selectIndex = indexPath.row;
    self.selectedType = selectIndex;
    
    if (self.originType == self.selectedType) {
        _comfirmBtn.backgroundColor = hexStringToColor(@"D8D8D8");
        [_comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _comfirmBtn.enabled = NO;
    }else{
        _comfirmBtn.backgroundColor = Color(240, 40, 31);
        [_comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _comfirmBtn.enabled = YES;
    }
}

#pragma mark - getter and setter
-(UITableView *)mainTab{
    if (!_mainTab) {
        _mainTab = [[UITableView alloc]init];
        _mainTab.delegate = self;
        _mainTab.dataSource = self;
        _mainTab.scrollEnabled = NO;
        _mainTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTab.backgroundColor = hexStringToColor(@"F8F8F8");
    }
    return _mainTab;
}

-(UIButton *)comfirmBtn{
    if (!_comfirmBtn) {
        _comfirmBtn = [UIButton new];
        _comfirmBtn.layer.cornerRadius = 2*layoutBy6();
        [_comfirmBtn setTitle:iStoreLocalizedString(@"确定") forState:UIControlStateNormal];
        [_comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_comfirmBtn addTarget:self action:@selector(comfirmAction) forControlEvents:UIControlEventTouchUpInside];
        _comfirmBtn.backgroundColor = hexStringToColor(@"D8D8D8");
        [_comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _comfirmBtn.enabled = NO;
    }
    return _comfirmBtn;
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
