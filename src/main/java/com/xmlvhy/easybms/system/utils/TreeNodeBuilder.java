package com.xmlvhy.easybms.system.utils;

import com.google.common.collect.Lists;
import org.apache.commons.collections.CollectionUtils;

import java.util.*;

/**
 * @ClassName TreeNodeBuilder
 * @Description TODO: 封装左侧菜单树数据结构
 * @Author 小莫
 * @Date 2019/07/06 12:14
 * @Version 1.0
 **/
public class TreeNodeBuilder {

    /**
     * 功能描述: 通过二级循环处理层级数据
     * @Author 小莫
     * @Date 12:27 2019/07/06
     * @param treeNodes: 当前所有的父级菜单以及子菜单
     * @param rootId：父级菜单的ID
     * @return java.util.List<com.xmlvhy.easybms.system.utils.TreeNode>
     */
    public static List<TreeNode> builder(List<TreeNode> treeNodes,Integer rootId){

        if (CollectionUtils.isEmpty(treeNodes)) {
            return Lists.newArrayList();
        }
        //从子节点的角度上分析，把所有的节点当做子节点（根节点id=0，看成一个父节点id为0的，虽然不存在）
        List<TreeNode> nodes = Lists.newArrayList();
        for (TreeNode t1:treeNodes){
            //子节点
            TreeNode child = t1;
            if (t1.getPid() == rootId) { //判断是否是父级菜单(当前对象的根节点)
                nodes.add(t1);
            }
            for (TreeNode innerTreeNode:treeNodes){
                //父节点
                TreeNode parent = innerTreeNode;
                if (child.getPid() == innerTreeNode.getId()) { //说明child是parent的子菜单
                    //组合父子节点的关系
                    parent.getChildren().add(child); //加入到对应的父级菜单中
                    break;
                }
            }
        }
        return nodes;
    }

    /**
     * 功能描述: 获取菜单导航树
     * @Author 小莫
     * @Date 10:29 2019/07/08
     * @param treeNodeList
     * @param rootId
     * @return java.util.List<com.xmlvhy.easybms.system.utils.TreeNode>
     */
    public static List<TreeNode> buildMenuTreeByMap(List<TreeNode> treeNodeList,Integer rootId){

        if (CollectionUtils.isEmpty(treeNodeList)) {
            return Lists.newArrayList();
        }
        //排序
        //Collections.sort(treeNodeList,treeNodeComparator);

        //组合map数据结构 key -> id  value -> TreeNode
        Map<Integer,TreeNode> treeNodeMap = new HashMap<>();
        for (TreeNode treeNode : treeNodeList){
            treeNodeMap.put(treeNode.getId(),treeNode);
        }

        //获取节点数据
        List<TreeNode> treeNodeData = Lists.newArrayList();
        for (TreeNode node : treeNodeList){
            if (node.getPid().equals(rootId)) {
                //根节点，无父节点
                treeNodeData.add(node);
            }else if (node.getPid() != 0){ //排除pid = 0的节点，这里根节点为1，只支持二级菜单
                TreeNode parent = treeNodeMap.get(node.getPid());
                parent.getChildren().add(node);
            }
        }
        return treeNodeData;
    }

    /**
     * 菜单排序，按照排序码
     */
    private static Comparator<TreeNode> treeNodeComparator = new Comparator<TreeNode>() {
        @Override
        public int compare(TreeNode o1, TreeNode o2) {
            return o1.getOrdernum() - o2.getOrdernum();
        }
    };

}
