package com.xmlvhy.easybms.system.utils;


import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.ser.impl.SimpleFilterProvider;
import lombok.extern.slf4j.Slf4j;

/**
 * @ClassName JsonMapper
 * @Description TODO: json转换工具类
 * @Author 小莫
 * @Date 2019/07/05 11:55
 * @Version 1.0
 **/
@Slf4j
public class JsonMapper {

    private static ObjectMapper objectMapper = new ObjectMapper();

    static {
        //配置objectMapper
        objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
        //objectMapper.setFilters(new SimpleFilterProvider().setFailOnUnknownId(false));
        objectMapper.setFilterProvider(new SimpleFilterProvider().setFailOnUnknownId(false));
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
    }

    /**
     * 功能描述: 对象转化为 json 字符串
     *
     * @param src 实体类对象
     * @return java.lang.String json字符串
     * @Author 小莫
     * @Date 11:27 2019/06/05
     */
    public static <T> String object2String(T src) {
        if (src == null) {
            return null;
        }
        try {
            return src instanceof String ? (String) src : objectMapper.writeValueAsString(src);
        } catch (Exception e) {
            log.warn("parse object to string exception", e);
            return null;
        }
    }

    /**
     * 功能描述: json字符串转化为实体对象
     * @Author 小莫
     * @Date 11:35 2019/06/05
     * @param src json 字符串
     * @param tTypeReference 实体类对象
     * @return T
     */
    public static <T> T string2Object(String src, TypeReference tTypeReference) {
        if (src == null || tTypeReference == null) {
            return null;
        }
        try {
            return (T) (tTypeReference.getType().equals(String.class) ? src : objectMapper.readValue(src, tTypeReference));
        } catch (Exception e) {
            log.warn("parse string to object exception,String: {}, TypeReference<T>: {} , error: {}", src, tTypeReference, e);
            return null;
        }
    }
}
