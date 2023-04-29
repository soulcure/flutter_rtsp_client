package com.skyfend.rtsp.flutter_rtsp_client;

import java.util.HashMap;
import java.util.Map;

public class ApiMessage {
    private Long viewId;
    private String uri;
    private Long type;


    public Long getViewId() {
        return viewId;
    }

    public void setViewId(Long setterArg) {
        this.viewId = setterArg;
    }


    public String getUri() {
        return uri;
    }

    public void setUri(String setterArg) {
        this.uri = setterArg;
    }


    public Long getType() {
        return type;
    }

    public void setType(Long setterArg) {
        this.type = setterArg;
    }


    Map<String, Object> toMap() {
        Map<String, Object> toMapResult = new HashMap<>();
        toMapResult.put("viewId", viewId);
        toMapResult.put("uri", uri);
        toMapResult.put("type", type);
        return toMapResult;
    }

    static ApiMessage fromMap(Map<String, Object> map) {
        ApiMessage fromMapResult = new ApiMessage();
        Object viewId = map.get("viewId");
        fromMapResult.viewId = (viewId == null) ? null : ((viewId instanceof Integer) ? (Integer) viewId : (Long) viewId);
        Object uri = map.get("uri");
        fromMapResult.uri = (String) uri;
        Object type = map.get("type");
        fromMapResult.type = (type == null) ? null : ((type instanceof Integer) ? (Integer) type : (Long) type);
        return fromMapResult;
    }
}
