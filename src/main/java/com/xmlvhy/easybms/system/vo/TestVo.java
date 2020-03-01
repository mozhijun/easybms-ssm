package com.xmlvhy.easybms.system.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @ClassName TestVo
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/05 12:15
 * @Version 1.0
 **/
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("测试实体类")
public class TestVo {

    @NotNull(message = "用户id必须传")
    @Min(value = 1,message = "uid至少大于0")
    @Max(value = 20,message = "uid不能大于20")
    @ApiModelProperty(value = "用户的uid")
    private Integer uid;

    @NotBlank(message = "name不能为空")
    @ApiModelProperty(value = "用户名")
    private String name;

    @NotNull(message = "年龄必须传")
    @Min(value = 1,message = "年龄必须大于1")
    @Max(value = 200,message = "年龄不能大于200")
    @ApiModelProperty(value = "用户年龄")
    private Integer age;

    @NotEmpty(message = "角色不能为空")
    @ApiModelProperty(value = "用户的所有角色")
    private List<String> roles;
}
