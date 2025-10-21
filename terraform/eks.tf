resource "aws_eks_cluster" "demo" {
  name     = "${var.prefix}-eks"
  role_arn = aws_iam_role.admin_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.public.id]
    endpoint_public_access = true   # public api server
    endpoint_private_access = false
    public_access_cidrs = ["0.0.0.0/0"]
  }
  depends_on = [aws_iam_role_policy.admin_policy]
}

resource "aws_eks_node_group" "demo_nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "${var.prefix}-ng"
  node_role_arn   = aws_iam_role.admin_role.arn # insecure: using admin role for nodes
  subnet_ids      = [aws_subnet.public.id]
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  instance_types = ["t3.medium"]
}

