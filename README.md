# keychainDemo

### 在项目中,导入`MXKeyChain.h MXKeyChain.m`调用即可

#### 存：
```
+ (void)keyChainSaveString:(NSString *)string WithSecureKey:(NSString *)secureKey;
```

#### 取：
```
+ (NSString *)keyChainLoadStringWithSecureKey:(NSString *)secureKey;
```

#### 删：
```
+ (void)keyChainDeleteStringWithSecureKey:(NSString *)secureKey;
```

### 详情请移步[Henry的博客](https://henry519.github.io/)
