package com.xmlvhy.easybms.system.utils;


import lombok.extern.slf4j.Slf4j;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.codehaus.jackson.map.ser.impl.SimpleFilterProvider;
import org.codehaus.jackson.type.TypeReference;

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
        objectMapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
        objectMapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
        objectMapper.setFilters(new SimpleFilterProvider().setFailOnUnknownId(false));
        objectMapper.setSerializationInclusion(JsonSerialize.Inclusion.NON_EMPTY);
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
