package com.xmlvhy.easybms.system.config;

import com.google.common.base.Function;
import com.google.common.base.Optional;
import com.google.common.base.Predicate;
import com.google.common.collect.Lists;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import springfox.documentation.RequestHandler;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.service.Parameter;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.List;

/**
 * @ClassName SwaggerConfig
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/05 19:20
 * @Version 1.0
 **/
@EnableSwagger2
@EnableWebMvc
@Configuration
public class SwaggerConfig {

    // 定义分隔符,配置Swagger多包
    private static final String splitor = ";";

    @Bean
    public Docket api(){
        Parameter parameter = new ParameterBuilder()
                //参数名称
                .name("token")
                //参数放在请求头
                .parameterType("header")
                //参数描述
                .description("用户令牌")
                //参数必须传
                .required(true)
                //参数类型
                .modelRef(new ModelRef("String"))
                .build();
        List<Parameter> parameters = Lists.newArrayList();
        parameters.add(parameter);

        return new Docket(DocumentationType.SWAGGER_2)
                //设置全局参数
                .globalOperationParameters(parameters)
                .select()
                //.apis(RequestHandlerSelectors.basePackage("com.xmlvhy.easybms.system.controller"))
                //扫描所有有注解的api，用这种方式更灵活
                //.apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                .apis(basePackage("com.xmlvhy.easybms.system.controller"+splitor+
                        "com.xmlvhy.easybms.business.controller"))
                //扫描所有
                //.apis(RequestHandlerSelectors.any())
                //路径的配置方式，所有的url
                .paths(PathSelectors.any())
                .build()
                .apiInfo(apiInfo());
    }

    /**
     * 功能描述: API文档基本信息设置
     * @Author 小莫
     * @Date 19:29 2019/07/05
     * @param
     * @return springfox.documentation.service.ApiInfo
     */
    private ApiInfo apiInfo() {
        Contact contact = new Contact("小莫","https://www.xmlvhy.com","1059224309@qq.com");
       return new ApiInfoBuilder()
               .title("EasyBMS接口文档")
               .description("对外开放接口")
               .version("v1.0")
               .license("遵循开源协议...")
               .licenseUrl("https://www.xmlvhy.com")
               .contact(contact)
               .build();
        }

    /**
     * 重写basePackage方法，使能够实现多包访问，复制贴上去
     * @author  teavamc
     * @date 2019/1/26
     * @return com.google.common.base.Predicate<springfox.documentation.RequestHandler>
     */
    public static Predicate<RequestHandler> basePackage(final String basePackage) {
        return input -> declaringClass(input).transform(handlerPackage(basePackage)).or(true);
    }

    private static Function<Class<?>, Boolean> handlerPackage(final String basePackage)     {
        return input -> {
            // 循环判断匹配
            for (String strPackage : basePackage.split(splitor)) {
                boolean isMatch = input.getPackage().getName().startsWith(strPackage);
                if (isMatch) {
                    return true;
                }
            }
            return false;
        };
    }

    private static Optional<? extends Class<?>> declaringClass(RequestHandler input) {
        return Optional.fromNullable(input.declaringClass());
    }

}
