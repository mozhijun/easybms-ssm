package com.xmlvhy.easybms.system.common;

import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.collections.MapUtils;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.util.*;

/**
 * @ClassName BeanValidator
 * @Description TODO: bean校验器
 * @Author 小莫
 * @Date 2019/07/05 12:03
 * @Version 1.0
 **/
public class BeanValidator {
    private static ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();

    /**
     * 功能描述: 校验单个对象
     * @Author 小莫
     * @Date 11:00 2019/06/05
     * @param t
     * @param groups
     * @return java.util.Map<java.lang.String,java.lang.String>
     */
    private static <T> Map<String, String> validate(T t, Class... groups) {
        Validator validator = validatorFactory.getValidator();
        Set<ConstraintViolation<T>> violationSet = validator.validate(t, groups);
        if (violationSet.isEmpty()) {
            return Collections.emptyMap();
        } else {
            LinkedHashMap errors = Maps.newLinkedHashMap();
            Iterator iterator = violationSet.iterator();
            while (iterator.hasNext()) {
                ConstraintViolation violation = (ConstraintViolation) iterator.next();
                errors.put(violation.getPropertyPath().toString(), violation.getMessage());
            }
            return errors;
        }
    }

    /**
     * 功能描述: 校验集合对象
     * @Author 小莫
     * @Date 10:59 2019/06/05
     * @param collection
     * @return java.util.Map<java.lang.String,java.lang.String>
     */
    public static Map<String, String> validateList(Collection<?> collection) {
        //校验是否为空
        Preconditions.checkNotNull(collection);
        Iterator iterator = collection.iterator();
        Map errors;
        do {
            if (!iterator.hasNext()) {
                return Collections.emptyMap();
            }

            Object object = iterator.hasNext();
            errors = validate(object, new Class[0]);
        } while (errors.isEmpty());
        return errors;
    }

    /**
     * 功能描述: 校验单个对象或集合
     * @Author 小莫
     * @Date 10:58 2019/06/05
     * @param first
     * @param objects
     * @return java.util.Map<java.lang.String,java.lang.String>
     */
    public static Map<String, String> validateObject(Object first, Object... objects) {
        if (objects != null && objects.length > 0) {
            return validateList(Lists.asList(first, objects));
        } else {
            return validate(first, new Class[0]);
        }
    }

    /**
     * 功能描述: 检测参数是否符合要求，不符合抛出自定义ParamException
     * @Author 小莫
     * @Date 10:58 2019/06/05
     * @param param
     * @return void
     */
    public static void check(Object param) throws ParamsException{
        Map<String,String> map = BeanValidator.validateObject(param);
        if (MapUtils.isNotEmpty(map)) {
            throw new ParamsException(map.toString());
        }
    }
}
